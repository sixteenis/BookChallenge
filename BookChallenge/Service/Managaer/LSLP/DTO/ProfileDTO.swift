//
//  ProfileDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/24/24.
//

import Foundation


struct ProfileDTO: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let followers: [String]
    let following: [String]
    let posts: [String]
}
