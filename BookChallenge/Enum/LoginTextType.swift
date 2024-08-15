//
//  LoginTextFiled.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import Foundation

enum LoginTextType {
    case email
    case nickName
    case password
    case repassword
    
    
    
    var logo: String {
        switch self {
        case .email:
            "envelope.fill"
        case .password, .repassword:
            "lock.fill"
        case .nickName:
            "person.fill"
        }
    }
    var placeholder: String {
        switch self {
        case .email:
            "이메일"
        case .password:
            "비밀번호"
        case .nickName:
            "닉네임"
        case .repassword:
            "비밀번호 확인"
        }
    }
    var secure: Bool {
        switch self {
        case .email:
            false
        case .password, .repassword:
            true
        case .nickName:
            false
        }
    }
    
}
