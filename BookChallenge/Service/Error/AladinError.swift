//
//  AladinError.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

enum AladinError: Int, Error, LoggableError {

    
    var message: String {
        switch self {
        case .network:
            "네트워크 오류가 발생했습니다."
        }
    }
    
    case network = 400
    
    
}
