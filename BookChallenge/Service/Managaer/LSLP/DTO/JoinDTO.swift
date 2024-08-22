//
//  JoinDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct JoinBody: Encodable {
    let email: String
    let password: String
    let nick: String
}

struct JoinDTO: Decodable {
    let user_id: String
    let email: String
    let nick: String
}
