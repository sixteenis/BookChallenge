//
//  FetchPosts.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct FetchPostsQuery: Encodable {
    let next: String
    let limit: String = "10"
    let product_id = PostProductID.makeRoom
}

struct FetchPostsDTO: Decodable {
    let data: [RoomPostDTO]
    
}
struct RoomPostDTO: Decodable {
    let title: String
    let id: String
    let deadLine: String
    let limitPerson: Int
    let content: String
    let page: String
    let roomState: String
    let price: Int
    let files: [String]
    let likes: [String]
    let comments: [UserDTO]
    enum CodingKeys: String, CodingKey {
        case title
        case id = "content"
        case deadLine = "content1"
        case limitPerson = "content2"
        case content = "content3"
        case page = "content4"
        case roomState = "content5"
        case files
        case price
        case likes
        case comments
    }
}


