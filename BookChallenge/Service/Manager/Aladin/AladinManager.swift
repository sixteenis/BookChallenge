//
//  AladinManager.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

import RxSwift
import Alamofire

final class AladinManager {
    static let shared = AladinManager()
    private init() {}
    
    func getBestseller() -> Single<Result<[Book],AladinError>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try AladinRouter.fetchBestseller.asURLRequest()
                AF.request(request)
                    .responseDecodable(of: BestsellerDTO.self) { response in
                        switch response.result {
                        case .success(let data):
                            print(data)
                            observer(.success(.success(data.item)))
                        case .failure(_):
                            switch response.response?.statusCode {
                            case 400:
                                observer(.success(.failure(.network)))
                            case 401:
                                observer(.success(.failure(.network)))
                            default:
                                observer(.success(.failure(.network)))
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
