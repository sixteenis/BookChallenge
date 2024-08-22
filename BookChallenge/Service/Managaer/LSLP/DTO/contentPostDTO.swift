//
//  contentPostModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/21/24.
//

import Foundation

struct ContentPostBody: Encodable {
    let title: String //제목
    let content: String // 책 id
    let content1: String //종료일
    let content2: Int //인원
    let content3: String // 내용
    let content4: String //책 페이지
    let content5: String = RoomState.open// 현재 상황
    let price: Int
    let product_id: String = PostProductID.makeRoom
    let files: [String]
    init(title: String, tag: String, deadLine: String, limitPreson: Int, content: String, page: String, files: [String], price: Int) {
        self.title = title
        self.content = "#" + tag
        self.content1 = deadLine
        self.content2 = limitPreson
        self.content3 = content
        self.content4 = page
        self.files = files
        self.price = price
    }
    init(book: BookDTO, title: String, deadLine: String, limitPreson: Int, content: String, files: [String]) {
        self.title = title
        self.content = "#" + book.isbn13
        self.content1 = deadLine
        self.content2 = limitPreson
        self.content3 = content
        self.content4 = book.subInfo.itemPage?.formatted() ?? "0"
        self.files = files
        self.price = book.priceSales
    }
}
struct ContentPostDTO: Decodable {
    let post_id: String
}
