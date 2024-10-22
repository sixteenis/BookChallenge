//
//  CompletionModel.swift
//  BookChallenge
//
//  Created by 박성민 on 10/22/24.
//

import Foundation

enum CompletionType {
    case success
    case fail
    
    var title: String {
        switch self {
        case .success:
            return "챌린지 완료"
        case .fail:
            return "챌린지 실패"
        }
    }
    
}
struct CompletionModel {
    let imageURL: String
    let title: String
    let isCompletion: CompletionType
    let totalPage: Int
    let resultPage: Int
}
