//
//  BookModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

struct BookModel {
    let post: String
    let id: String
    let title: String
    let top: Int
    
    init(dto: Book, top: Int) {
        self.post = dto.cover
        self.id = dto.isbn13
        self.title = dto.title
        self.top = top
    }
}
