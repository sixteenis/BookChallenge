//
//  Router.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation
import Alamofire
enum UserRouter {
    case login(query: LoginQuery) //로그인
    case refresh //토큰 갱신
    case fetchProfile // 내 프로필 조회
    case editProfile(query: EditProfileQuery) // 프로필 수정
    case fetchOtherProfile(id: String) //다른 유저 프로필 조회
    case withdrawId //탈퇴
}
extension UserRouter: LSLPTargetType {
        var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
            return .post
        case .refresh:
            return .get
        case .fetchProfile:
            return .get
        case .editProfile:
            return .put
        case .fetchOtherProfile:
            return .get
        case .withdrawId:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItmes: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .editProfile(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        default:
            return nil
        }
        
    }
    
    var baseURL: String {
        return LSLP.baseURL + "v1"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .refresh:
            return "/auth/refresh"
        case .fetchProfile, .editProfile:
            return "/users/me/profile"
        case .fetchOtherProfile(let id):
            return "/users/\(id)/profile"
        case .withdrawId:
            return "/users/withdraw"
        }
    }
    var header: [String: String] {
        switch self {
        case .login:
            let header = [
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
            return header
        case .refresh:
            let header = [
                BaseHeader.authorization.rawValue: UserManager.shared.token,
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key,
                BaseHeader.refresh.rawValue: UserManager.shared.refreshToken
            ]
            return header
        case .fetchProfile:
            let header = [
                BaseHeader.authorization.rawValue: UserManager.shared.token,
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
            return header
        case .editProfile, .fetchOtherProfile, .withdrawId:
            let header = [
                BaseHeader.authorization.rawValue: UserManager.shared.token,
                BaseHeader.contentType.rawValue: BaseHeader.multipart.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
            return header
            
        }
    }
}
