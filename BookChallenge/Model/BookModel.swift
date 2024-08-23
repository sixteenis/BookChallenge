//
//  BookModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/23/24.
//

import Foundation

struct BookModel {
    let title: String
    let bookURL: String
    let author: String
    let publisher: String
    let pubDate: String
    let description: String
    let id: String
    let price: Int
    let page: Int
    
    init(title: String, bookURL: String, author: String, publisher: String, pubDate: String, description: String, id: String, price: Int, page: Int) {
        self.title = title
        self.bookURL = bookURL
        self.author = author
        self.publisher = publisher
        self.pubDate = pubDate
        self.description = description
        self.id = id
        self.price = price
        self.page = page
    }
    init() {
        self.init(
            title: "",
            bookURL: "",
            author: "",
            publisher: "",
            pubDate: "",
            description: "",
            id: "",
            price: 0,
            page: 0)
    }
}
