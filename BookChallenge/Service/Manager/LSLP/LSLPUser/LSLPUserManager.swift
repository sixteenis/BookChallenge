//
//  LSLPNetworkManager.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation

import Alamofire
import RxSwift

final class LSLPUserManager {
    static let shared = LSLPUserManager()
    private init() {}
    // MARK: - 로그인
    func createLogin(email: String, password: String, completionHandler: ((Result<Void,LSLPError>) -> ())? = nil) {
        do {
            let query = LoginQuery(email: email, password: password)
            let request = try UserRouter.login(query: query).asURLRequest()
            AF.request(request)
                .responseDecodable(of: LoginDTO.self) { response in
                    switch response.result {
                    case .success(let data):
                        UserManager.shared.token = data.token
                        UserManager.shared.refreshToken = data.refresh
                        UserManager.shared.email = email
                        UserManager.shared.password = password
                    case .failure(_):
                        switch response.response?.statusCode {
                        case 400:
                            completionHandler?(.failure(.err400))
                        case 401:
                            completionHandler?(.failure(.err401))
                        default:
                            completionHandler?(.failure(.networkErr))
                        }
                        
                    }
                }
                
        } catch {
            print(error)
        }
        
    }
    // MARK: - 토큰 갱신
    func refreshToke(completion: (() -> ())? =  nil){
        do {
            let request = try UserRouter.refresh.asURLRequest()
            AF.request(request)
                .responseDecodable(of: RefreshTokeDTO.self) { response in
                    if response.response?.statusCode == 418 {
                        self.createLogin(email: UserManager.shared.email, password: UserManager.shared.password) { [weak self] _ in
                            self?.refreshToke()
                        }
                    }
                    switch response.result {
                    case .success(let data):
                        print("OK", data)
                        UserManager.shared.token = data.accessToken
                        completion?()
                    case .failure(let error):
                        print("Fail", error)
                    }
                }
        } catch {
            print("토큰 갱신 오류!")
        }
    }
    //case editProfile(query: EditProfileQuery) // 프로필 수정
    //case fetchOtherProfile(id: String) //다른 유저 프로필 조회
    //case withdrawId //탈퇴
    func fetchProfile() {
        do {
            let request = try UserRouter.fetchProfile.asURLRequest()
            AF.request(request)
                .responseDecodable(of: ProfileDTO.self) { response in
                    if response.response?.statusCode == 419 {
                        self.createLogin(email: UserManager.shared.email, password: UserManager.shared.password)
                    }
                    switch response.result {
                    case .success(let data):
                        print("OK", data)
                    case .failure(let error):
                        print("Fail", error)
                    }
                }
        } catch {
            print("프로필 조회 오류!")
        }
    }
    
    func editProfile(nick: String) {
        do {
            let query = EditProfileQuery(nick: nick)
            let request = try UserRouter.editProfile(query: query).asURLRequest()
            AF.request(request)
            .responseDecodable(of: ProfileDTO.self) { response in
                if response.response?.statusCode == 419 { //토큰 만료시!
                    self.refreshToke {
                        self.editProfile(nick: nick)
                    }
                }
                switch response.result {
                case .success(let data):
                    print("??????성공한겨?")
                    print("OK", data)
                case .failure(let error):
                    print("Fail", error)
                }
            }
        } catch {
            print("프로필 조회 오류!")
        }
    }
    
    
}

// MARK: - 로그인
//    func createLogin(email: String, password: String) {
//        return Single.create { observer -> Disposable in
//            do {
//                let query = LoginQuery(email: email, password: password)
//                let request = try UserRouter.login(query: query).asURLRequest()
//                AF.request(request)
//                    .responseDecodable(of: LoginDTO.self) { response in
//                        switch response.result {
//                        case .success(let data):
//                            UserManager.shared.token = data.access
//                            UserManager.shared.refreshToken = data.refresh
//                            UserManager.shared.email = email
//                            UserManager.shared.password = password
//                            observer(.success(.success(true)))
//                        case .failure(_):
//                            switch response.response?.statusCode {
//                            case 400:
//                                observer(.success(.failure(.err400)))
//                            case 401:
//                                observer(.success(.failure(.err401)))
//                            default:
//                                observer(.success(.failure(.networkErr)))
//                            }
//
//                        }
//                    }
//
//            } catch {
//                print(error)
//            }
//            return Disposables.create()
//        }
//    }
