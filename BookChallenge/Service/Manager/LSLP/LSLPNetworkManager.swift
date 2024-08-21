//
//  LSLPNetworkManger.swift
//  BookChallenge
//
//  Created by 박성민 on 8/20/24.
//

import Foundation
import RxSwift
import RxCocoa

import Moya
import RxMoya

@frozen enum NetworkResult<T: Decodable> {
    case success(T)
    case failure(Error)
}

final class LSLPNetworkManager {
    static let shared = LSLPNetworkManager()
    private let disposeBag = DisposeBag()
    let provider = MoyaProvider<LSLPRouter>(plugins: [TokenAuthPlugin(tokenClosure: {
        UserManager.shared.token
    })])
    private init() {}
    
    func requestRx<D: Decodable>(requestType: LSLPRouter, resultModel: D.Type) -> Single<NetworkResult<D>> {
        print(UserManager.shared.token)
        return Single<NetworkResult<D>>.create { single in
            self.provider.rx.request(requestType)
                .debug()
                .catch({ err in

                    guard let moyaError = err as? MoyaError,
                          let statusCode = moyaError.response?.statusCode,
                          statusCode == 419 else {return Single.error(err)}
                    return Single.create { refreshSingle in
                        self.provider.request(.refresh(token: UserManager.shared.refreshToken)) { result in
                            switch result {
                            case .success(let response):
                                do {
                                    let decodeData = try JSONDecoder().decode(RefreshTokeDTO.self, from: response.data)
                                    UserManager.shared.token = decodeData.accessToken

                                    return refreshSingle(.failure(err))
                                } catch {
                                    return refreshSingle(.failure(err))
                                }
                            case .failure(let moyaErr):
                                return refreshSingle(.failure(moyaErr))
                                
                            }
                        }
                        return Disposables.create()
                        
                    }
                })
                .retry(3)
                .debug()
                .subscribe(with: self) { owner, response in
                    do {
                        let decodedData = try response.map(resultModel)
                        single(.success(.success(decodedData)))
                    } catch let err {
                        single(.success(.failure(err)))
                    }
                    
                } onFailure: { owner, error in
                    guard let moyaError = error as? MoyaError,
                          let statusCode = moyaError.response?.statusCode,
                          statusCode == 418 else {
                        return single(.success(.failure(error)))
                    }
                    single(.failure(error))
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    
}
