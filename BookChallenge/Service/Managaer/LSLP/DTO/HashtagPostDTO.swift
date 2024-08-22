//
//  HashtagPostDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation


struct HashtagPostQuery: Encodable {
    let next: String
    let limit: String
    let product_id: String
    let hashTag: String
}

struct HashtagPostDTO: Decodable {
    let data: [RoomPostDTO]
    let next_cursor: String
}
