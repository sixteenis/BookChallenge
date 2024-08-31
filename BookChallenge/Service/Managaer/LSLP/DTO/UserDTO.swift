//
//  UserDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct UserDTO: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String?
    //프로필은 나중에 하자!
}
