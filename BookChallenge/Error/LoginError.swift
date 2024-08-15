//
//  LoginError.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import Foundation

enum LoginError: Error, Alert {
    case filter
    case samePassword
    
    var title: String {
        switch self {
        case .filter:
            "입력 정보 확인"
        case .samePassword:
            "비밀번호 불일치"
        }
    }
    
    var message: String? {
        switch self {
        case .filter:
            "형식에 맞는 정보를 입력해주세요!"
        case .samePassword:
            "비밀번호를 확인해주세요."
        }
    }
    
    
    
}
