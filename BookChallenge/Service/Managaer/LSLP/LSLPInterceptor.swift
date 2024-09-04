//
//  LSLPInterceptor.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//
import Foundation
import Alamofire
import RxSwift
import Moya

final class Interceptor: RequestInterceptor {
    let retryDelay: TimeInterval = 5
    static let shared = Interceptor()
    private let disposeBag = DisposeBag()
    private init() {}
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        let path = urlRequest.url?.path(percentEncoded: true)
        
        guard urlRequest.url?.absoluteString.hasPrefix(LSLP.baseURL) == true,
              ["/join", "/login", "/validation"].contains(path) == false
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue(UserManager.shared.token, forHTTPHeaderField: BaseHeader.authorization.rawValue)

        
        print("adator 적용 \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        print("retry 진입: \(error)")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        LSLPNetworkManager.shared.requestToken { result in
            switch result {
            case .success(_):
                completion(.retryWithDelay(self.retryDelay))
            case .failure(let error):
                completion(.doNotRetryWithError(error))
//                print("실패후 진입!!! \(response.statusCode)")
//                let a = error as? MoyaError
//                print(a?.response?.statusCode)
//                guard let moyaErr =  error as? MoyaError, let moyaResponse = moyaErr.response, moyaResponse.statusCode == 418 else {
//                    print("가드문 들감 ㅅㅂ")
//                    //print(moyaResponse.statusCode)
//                    completion(.doNotRetryWithError(error))
//                    return
//                }
//                
//                print("진입 후!!!!!!!")
//                print(moyaResponse.statusCode)
//                    LSLPNetworkManager.shared.requestLogin { loginResult in
//                        print("이까지는 들오난????")
//                        switch loginResult {
//                        case .success(let success):
//                            completion(.retryWithDelay(self.retryDelay))
//                        case .failure(let failure):
//                            completion(.doNotRetryWithError(error))
//                        }
//                    }
                
//                if let afError = error.asAFError, let statusCode = afError.responseCode {
//                    print(statusCode)
//                    print("--------")
//                } else {
//                    completion(.doNotRetryWithError(error))
//                }
            }
        }

    }
}

