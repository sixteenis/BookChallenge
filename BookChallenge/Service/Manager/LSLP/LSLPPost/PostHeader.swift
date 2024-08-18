//
//  PostHeader.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

enum PostHeader: String {
    case authorization = "Authorization"
    case sesacKey = "SesacKey"
    case contentType = "Content-Type"
    case json = "application/json"
    
    case refresh = "Refresh"
    case multipart = "multipart/form-data"
}
