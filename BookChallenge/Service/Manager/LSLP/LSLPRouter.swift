//
//  Router.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation
import Alamofire
enum LSLPRouter {
    case login(query: LoginQuery)
    case fetchProfile
    case editProfile
    case refresh
}
extension LSLPRouter: LSLPTargetType {
        var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
            return .post
        case .fetchProfile:
            return .get
        case .editProfile:
            return .put
        case .refresh:
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
        case .fetchProfile, .editProfile:
            return "/users/me/profile"
        case .refresh:
            return "/auth/refresh"
        }
    }
    var header: [String: String] {
        switch self {
        case .login:
            let header = [
                LSLPHeader.contentType.rawValue: LSLPHeader.json.rawValue,
                LSLPHeader.sesacKey.rawValue: LSLP.key,
            ]
            return header
        case .fetchProfile:
            let header = [
                LSLPHeader.authorization.rawValue: UserManager.shared.token,
                LSLPHeader.contentType.rawValue: LSLPHeader.json.rawValue,
                LSLPHeader.sesacKey.rawValue: LSLP.key,
            ]
            return header
        case .editProfile:
            let header = [
                LSLPHeader.authorization.rawValue: UserManager.shared.token,
                LSLPHeader.sesacKey.rawValue: LSLP.key,
            ]
            return header
        case .refresh:
            let header = [
                LSLPHeader.authorization.rawValue: UserManager.shared.token,
                LSLPHeader.contentType.rawValue: LSLPHeader.json.rawValue,
                LSLPHeader.sesacKey.rawValue: LSLP.key,
                LSLPHeader.refresh.rawValue: UserManager.shared.refreshToken
            ]
            return header
        }
    }
}
