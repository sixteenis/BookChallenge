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
    }
    static let shared = UserManager()
    private init() {}
    
    @UserDefault(key: UserDefaultsKey.access.rawValue, defaultValue: "", storage: .standard)
    var token: String
    
    @UserDefault(key: UserDefaultsKey.refresh.rawValue, defaultValue: "", storage: .standard)
    var refreshToken: String
}
