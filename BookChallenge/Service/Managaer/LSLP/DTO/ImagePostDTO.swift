//
//  ImagePostModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/21/24.
//

import Foundation

struct ImagePostBody: Encodable {
    let files: Data
}

struct ImagePostDTO: Decodable {
    let files: [String]
}
