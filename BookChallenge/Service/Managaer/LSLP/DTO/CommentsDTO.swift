//
//  CommentsDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct CommentsBody: Encodable {
    let content: String
}

struct CommentsDTO: Decodable {
    let comment_id: String
    let content: String
    let createdAt: String
    let creator: UserDTO
}
