//
//  BookModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation


struct BookModel {
    let title: String
    let author: String
    let pubDate: String //발행일
    let description: String
    let isbn13: String
    let cover: String
    let publisher: String //출판사
    let page: Int?
    
    init(bookdto: BookDTO) {
        self.title = bookdto.title
        self.author = bookdto.author
        self.pubDate = bookdto.pubDate
        self.description = bookdto.description
        self.isbn13 = bookdto.isbn13
        self.cover = bookdto.cover
        self.publisher = bookdto.publisher
        self.page = nil
    }
    init(bookdto: DetailBookDTO) {
        self.title = bookdto.title
        self.author = bookdto.author
        self.pubDate = bookdto.pubDate
        self.description = bookdto.description
        self.isbn13 = bookdto.isbn13
        self.cover = bookdto.cover
        self.publisher = bookdto.publisher
        self.page = bookdto.subInfo[0].itemPage
    }
}
