//
//  BookModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/19/24.
//

import Foundation


struct BookModel {
    let postURL: String
    let title: String
    let descriptionHeader: String
    let description: String
    init(dto: BookDTO) {
        self.postURL = dto.cover
        self.title = Self.setTitle(page: dto.subInfo.itemPage, title: dto.title)
        self.descriptionHeader = "책 설명"
        self.description = dto.description
    }
    // MARK: - static으로 정의해서 빼놓는게 맞을까?
    static private func setTitle(page: Int?, title: String) -> String {
        let removeSubtitle = title.split(separator: "-").map(String.init)
        let removeSubtitle2 = removeSubtitle[0].split(separator: "(").map(String.init)
        let realPag = page ?? 0
        let setPage = "(\(realPag.formatted())p)"
        let result = setPage + removeSubtitle2[0]
        
        return result
    }
}
