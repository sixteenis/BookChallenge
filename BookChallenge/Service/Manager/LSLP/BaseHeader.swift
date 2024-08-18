//
//  BaseHeader.swift
//  BookChallenge
//
//  Created by 박성민 on 8/18/24.
//

import Foundation

enum BaseHeader: String {
    case authorization = "Authorization"
    case sesacKey = "SesacKey"
    
    case contentType = "Content-Type"
    
    case json = "application/json"
    
    case refresh = "Refresh"
    case multipart = "multipart/form-data"
}
