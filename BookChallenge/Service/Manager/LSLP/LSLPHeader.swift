//
//  Header.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation

enum LSLPHeader: String {
    case authorization = "Authorization"
    case sesacKey = "SesacKey"
    case refresh = "Refresh"
    case contentType = "Content-Type"
    case json = "application/json"
    case multipart = "multipart/form-data"
}
