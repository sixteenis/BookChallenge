//
//  UploadPostContentsQuery.swift
//  BookChallenge
//
//  Created by 박성민 on 8/18/24.
//

import Foundation

struct UploadPostContentsBody: Encodable {
    let title: String
    let content: String
    let content1: String
    let content2: String
    let content3: String
    let content4: String
    let content5: String
    let product_id: String
    let files: [String]?
    init(book: BookDTO, title: String, content: String, date: String, files: FilesDTO?) {
        self.title = title //제목
        self.content = "#" + book.isbn13 //책id
        self.content1 = content //내용
        self.content2 = book.subInfo.itemPage?.formatted() ?? "0" //챗페이지
        self.content3 = date //기간
        self.content4 = "5" //모집인원
        self.content5 = "open"
        self.product_id = LSLP.createChallengeRoomId
        self.files = files?.files
    }
    
}
