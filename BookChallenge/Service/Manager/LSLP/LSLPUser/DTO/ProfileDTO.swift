//
//  ProfileDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/18/24.
//

import Foundation

struct ProfileDTO: Decodable {
    let user_id: String?
    let email: String?
    let nick: String?
    let followers: [String]?
    let following: [String]?
    let posts: [String]?
    
//    "user_id": "65ca1c72fc5d2aa23995e98c",
//      "email": "ssesac12345@gmail.com",
//      "nick": "den",
//      "followers": [],
//      "following": [],
//    "posts": []
}
   


//enum CodingKeys: String, CodingKey {
//    case id = "user_id"
//    case email, nick
//    case profile = "profileImage"
//    case refresh = "refreshToken"
//    case access = "accessToken"
//}
