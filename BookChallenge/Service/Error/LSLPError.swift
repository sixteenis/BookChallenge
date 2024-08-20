//
//  LoginError.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import Foundation

enum LSLPError: Error, Alert {
    case filter
    case samePassword
    case networkErr
    case err400
    case err402
    case err409
    case err401
    case login
    
    var title: String {
        switch self {
        case .filter:
            "입력 정보 확인"
        case .samePassword:
            "비밀번호 불일치"
        case .networkErr:
            "네트워크 오류"
        case .err400, .err401, .err402, .err409:
            "입력 정보 확인"
        case .login:
            "로그인 만료"
            
        }
    
    }
    
    var message: String? {
        switch self {
        case .filter:
            "형식에 맞는 정보를 입력해주세요!"
        case .samePassword:
            "비밀번호를 확인해주세요."
        case .networkErr:
            "네트워크가 불안정합니다. 재시도 해주세요."
        case .err400:
            "필수값을 채워주세요"
        case .err401:
            "계정을 확인해주세요."
        case .login:
            "로그인을 재시도 해주세요."
        case .err402:
            "닉네임에 공백을 포함할 수 없어요."
        case .err409:
            "이미 존재하는 닉네임입니다."
        }
    }
    
    
    
}
