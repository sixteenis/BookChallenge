//
//  SearchBookWithIDDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

struct SearchBookWithIDDTO: Decodable {
    let item: [BookDTO]
}