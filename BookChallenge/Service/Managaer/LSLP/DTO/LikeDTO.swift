//
//  LikeDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct LikeBody: Encodable {
    let like_status: Bool
}
struct LikeDTO: Decodable {
    let like_status: Bool
}
