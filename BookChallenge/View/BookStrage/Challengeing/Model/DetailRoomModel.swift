//
//  DetailRoomModel.swift
//  BookChallenge
//
//  Created by 박성민 on 10/21/24.
//

import Foundation
struct DetailRoomModel {
    let postId: String
    let bookurl: String // 책???
    let bookTitle: String // 제목
    let booktotalPage: Int // 전체 페이지
    let startDate: String //시작일
    let endDate: String // 끝나는 일
    let totalDate: Int //전체
    let nowDate: Int // 현재
    let userData: [UserData]
}
struct UserData {
    let name: String //닉네임
    let profileImage: String // 프로필
    let nowPage: Int // 현재 페이지
    let totalPage: Int
    let date: String //
    let content: String
}


//struct BookRoomModel {
//    let postId: String
//    let bookurl: String
//    let bookTitle: String
//    let booktotalPage: Int
//    let bookNowPage: Int
//    let startDate: String
//    let endDate: String
//    let totalDate: Int
//    let nowDate: Int
//
//}
