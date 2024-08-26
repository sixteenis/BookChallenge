//
//  LSLPInterceptor.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//
import Foundation
import Alamofire
import RxSwift

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
            }
        }

    }
}

