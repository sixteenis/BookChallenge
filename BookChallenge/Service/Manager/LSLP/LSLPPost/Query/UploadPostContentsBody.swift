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
    let files: [String]
}
