//
//  LoginTextFiled.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import Foundation

enum LoginTextType: String {
    case email = ""
    case passwoard = "123"
    case nickName = "12312312"
    
    var logo: String {
        switch self {
        case .email:
            "envelope.fill"
        case .passwoard:
            "lock.fill"
        case .nickName:
            "person.fill"
        }
    }
    var placeholder: String {
        switch self {
        case .email:
            "이메일"
        case .passwoard:
            "비밀번호"
        case .nickName:
            "닉네임"
        }
    }
    var secure: Bool {
        switch self {
        case .email:
            false
        case .passwoard:
            true
        case .nickName:
            false
        }
    }
    
}
