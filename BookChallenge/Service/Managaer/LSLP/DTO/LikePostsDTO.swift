//
//  LikePostsDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct LikePostsQuery: Encodable {
    let next: String
    let limit: String
}

struct LikePostsDTO: Decodable {
    let data: [RoomPostDTO]
}
