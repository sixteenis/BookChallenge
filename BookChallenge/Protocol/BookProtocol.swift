//
//  SimpleBook.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

protocol BookProtocol {
    var title: String { get }
    var cover: String { get }
    var author: String { get }
    var publisher: String { get }
    var pubDate: String { get } //발행일
    var isbn13: String { get }
    var description: String { get }
    var subInfo: SubInfo { get }
}





