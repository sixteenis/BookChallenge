//
//  BookDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

struct BookDTO: Decodable {
    let title: String
    let author: String
    let pubDate: String //발행일
    let description: String
    let isbn13: String
    let cover: String
    let publisher: String //출판사
}

