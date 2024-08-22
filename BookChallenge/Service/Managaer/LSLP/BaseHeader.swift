//
//  BaseHeader.swift
//  BookChallenge
//
//  Created by 박성민 on 8/18/24.
//

import Foundation

enum BaseHeader: String {
    case sesacKey = "SesacKey"
    case authorization = "Authorization"
    case refresh = "Refresh"
    
    case contentType = "Content-Type"
    case multipart = "multipart/form-data"
    case json = "application/json"
}
