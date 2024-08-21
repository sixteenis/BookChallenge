//
//  LSLPNetworkManger.swift
//  BookChallenge
//
//  Created by 박성민 on 8/20/24.
//

import Foundation
import RxSwift
import RxCocoa

import Alamofire


final class LSLPNetworkManger {
    static let shared = LSLPNetworkManger()
    private init() {}
    let manger = PostManger.shared
    func createChallengeRoom(book: BookDTO, title: String, content: String, date: String, files: Data) {
        
        manger.uploadPostFiles(data: files) { [weak self] data in
            self?.manger.uploadPostContent(book: book, title: title, content: content, date: date, file: data)
        }
        
    }
    
}
