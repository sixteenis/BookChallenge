//
//  Router.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation
import Alamofire
enum UserRouter {
    case login(query: LoginQuery)
    case refresh
    case fetchProfile
    case editProfile
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
        
        }
    }
    var header: [String: String] {
        switch self {
        case .login:
            let header = [
                UserHeader.contentType.rawValue: UserHeader.json.rawValue,
                UserHeader.sesacKey.rawValue: LSLP.key,
            ]
            return header
        case .refresh:
            let header = [
                UserHeader.authorization.rawValue: UserManager.shared.token,
                UserHeader.contentType.rawValue: UserHeader.json.rawValue,
                UserHeader.sesacKey.rawValue: LSLP.key,
                UserHeader.refresh.rawValue: UserManager.shared.refreshToken
            ]
            return header
        case .fetchProfile:
            let header = [
                UserHeader.authorization.rawValue: UserManager.shared.token,
                UserHeader.contentType.rawValue: UserHeader.json.rawValue,
                UserHeader.sesacKey.rawValue: LSLP.key,
            ]
            return header
        case .editProfile:
            let header = [
                UserHeader.authorization.rawValue: UserManager.shared.token,
                UserHeader.sesacKey.rawValue: LSLP.key,
            ]
            return header
        
        }
    }
}
