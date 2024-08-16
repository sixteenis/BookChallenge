//
//  UserManager.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation

final class UserManager {
    private enum UserDefaultsKey: String {
        case access
        case refresh
        case email
        case password
    }
    static let shared = UserManager()
    private init() {}
    
    @UserDefault(key: UserDefaultsKey.access.rawValue, defaultValue: "", storage: .standard)
    var token: String
    
    @UserDefault(key: UserDefaultsKey.refresh.rawValue, defaultValue: "", storage: .standard)
    var refreshToken: String
    
    @UserDefault(key: UserDefaultsKey.email.rawValue, defaultValue: "", storage: .standard)
    var email: String
    
    @UserDefault(key: UserDefaultsKey.password.rawValue, defaultValue: "", storage: .standard)
    var password: String
}
