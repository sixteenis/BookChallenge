//
//  LSLPNetworkManger.swift
//  BookChallenge
//
//  Created by 박성민 on 8/20/24.
//

import Foundation
import RxSwift

import Moya


@frozen
enum NetworkResult<T: Decodable> {
    case success(T)
    case failure(LoggableError)
}


final class LSLPNetworkManager{
    static let shared = LSLPNetworkManager()
    private let disposeBag = DisposeBag()
    var provider = MoyaProvider<LSLPRouter>(session: Session(interceptor: Interceptor.shared))
    private init() {}
    func request<T>(target: LSLPRouter, dto: T.Type) -> Single<NetworkResult<T>>{
        provider = MoyaProvider<LSLPRouter>(session: Session(interceptor: Interceptor.shared))
        return Single<NetworkResult<T>>.create { (single) -> Disposable in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    guard let data = try? response.map(T.self) else {
                        single(.success(.failure(NetworkError.badRequest)))
                        return
                    }
                    single(.success(.success(data)))
                case .failure(let error):
                    guard let statusCode = error.response?.statusCode,
                          let networkError = NetworkError(rawValue: statusCode)
                    else {
                        single(.success(.failure(NetworkError.serverError)))
                        return
                    }
                    single(.success(.failure(networkError)))
                }
            }
            return Disposables.create()
        }
        
    }
    func requestToken( completion: @escaping (Result<Void,Error>) -> ()) {
        provider = MoyaProvider<LSLPRouter>(session: Session(interceptor: Interceptor.shared))
        self.provider.request(LSLPRouter.refresh) { result in
            print("---------------리프래시 토큰--------------")
            switch result {
            case .success(let response):
                guard let data = try? response.map(RefreshTokenDTO.self) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                UserManager.shared.token = data.accessToken
                completion(.success(()))
            case .failure(let err):
                if err.response?.statusCode == 418 || err.response?.statusCode == 401{
                    self.requestLogin { response in
                        switch response {
                        case .success(let result):
                            completion(.success(result))
                        case .failure(let err):
                            completion(.failure(err))
                        }
                    }
                }else {
                    completion(.failure(err))
                }
            }
        }
        
    }
    func requestLogin(completion: @escaping (Result<Void,Error>) -> () ) {
        provider = MoyaProvider<LSLPRouter>(session: Session(interceptor: Interceptor.shared))
        self.provider.request(LSLPRouter.login(login: .init(email: UserManager.shared.email, password: UserManager.shared.password))) { result in
            switch result {
            case .success(let response):
                guard let data = try? response.map(LoginDTO.self) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                UserManager.shared.token = data.token
                UserManager.shared.refreshToken = data.refresh
            case .failure(let err):
                print(err)
            }
        }
    }
    func requestUserProfile() {
        provider = MoyaProvider<LSLPRouter>(session: Session(interceptor: Interceptor.shared))
        self.provider.request(.fetchMeProfile) { result in
            switch result {
            case .success(let response):
                guard let data = try? response.map(ProfileDTO.self) else { return }
                UserManager.shared.nick = data.nick
                UserManager.shared.userId = data.user_id
            case .failure(let err):
                print(err)
            }
        }
    }
    
}

