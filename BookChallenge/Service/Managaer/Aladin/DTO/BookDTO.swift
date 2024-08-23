//
//  BookDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

struct BookDTO: Decodable {
    let title: String
    let author: String //작가
    let pubDate: String //발행일
    let description: String
    let isbn13: String
    let cover: String
    let publisher: String //출판사
    let priceSales: Int
    let subInfo: SubInfo
    
    func transformBookModel() -> BookModel {
        let title = subInfo.subTitle ?? title
        let model = BookModel(
            title: title,
            bookURL: self.cover,
            author: self.author,
            publisher: self.publisher,
            pubDate: self.pubDate,
            description: self.description,
            id: self.isbn13,
            price: self.priceSales,
            page: self.subInfo.itemPage ?? 0
        )
        return model
    }
    
}

struct SubInfo: Decodable {
    let itemPage: Int?
    let subTitle: String?
}
