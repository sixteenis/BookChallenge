//
//  LoginModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/21/24.
//

import Foundation

struct LoginBody: Encodable {
    let email: String
    let password: String
}

struct LoginDTO: Decodable {
    let id: String
    let email: String
    let nick: String
    //let profile: String?
    let token: String
    let refresh: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email, nick
        //case profile = "profileImage"
        case refresh = "refreshToken"
        case token = "accessToken"
    }
}
