//
//  LoginDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation

struct LoginDTO: Decodable {
    let id: String
    let email: String
    let nick: String
    let profile: String?
    let access: String
    let refresh: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email, nick
        case profile = "profileImage"
        case refresh = "refreshToken"
        case access = "accessToken"
    }
}
