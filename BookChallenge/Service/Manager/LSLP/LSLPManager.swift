//
//  LSLPNetworkManager.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation

import Alamofire
import RxSwift

final class LSLPManager {
    static let shared = LSLPManager()
    private init() {}
    
    func createLogin(email: String, password: String) -> Single<Result<Bool,LoginError>>{
        return Single.create { observer -> Disposable in
            do {
                let query = LoginQuery(email: email, password: password)
                let request = try Router.login(query: query).asURLRequest()
                AF.request(request)
                    .responseDecodable(of: LoginDTO.self) { response in
                        switch response.result {
                        case .success(let data):
                            UserManager.shared.token = data.access
                            UserManager.shared.refreshToken = data.refresh
                            UserManager.shared.email = email
                            UserManager.shared.password = password
                            observer(.success(.success(true)))
                        case .failure(_):
                            switch response.response?.statusCode {
                            case 400:
                                observer(.success(.failure(.err400)))
                            case 401:
                                observer(.success(.failure(.err401)))
                            default:
                                observer(.success(.failure(.networkErr)))
                            }
                            
                        }
                    }
                
            } catch {
                print(error)
            }
            return Disposables.create()
        }
    }
    
}
