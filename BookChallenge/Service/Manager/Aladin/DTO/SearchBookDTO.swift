//
//  SearchBookDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

struct SearchBookDTO: Decodable {
    let totalResults: Int
    let itemsPerPage: Int
    let item: [BookDTO]
}
