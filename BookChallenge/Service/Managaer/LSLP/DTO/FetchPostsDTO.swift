//
//  FetchPosts.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct FetchPostsQuery: Encodable {
    let next: String
    let limit: String = "5"
    let product_id = PostProductID.makeRoom
}

struct FetchPostsDTO: Decodable {
    let data: [RoomPostDTO]
    let next_cursor: String
    
}
struct RoomPostDTO: Decodable {
    let post_id: String //
    let title: String //
    let id: String //
    let deadLine: String //
    let limitPerson: String//
    let content: String//
    let page: String
    let roomState: String
    let price: Int?
    let files: [String]
    let likes: [String]
    let creator: UserDTO
    //let comments: [UserDTO]
    enum CodingKeys: String, CodingKey {
        case post_id
        case title
        case id = "content"
        case deadLine = "content1"
        case limitPerson = "content2"
        case content = "content3"
        case page = "content4"
        case roomState = "content5"
        case files
        case price
        case likes
        case creator
        //case comments
    }
    func transformChallengePostModel() -> ChallengePostModel {
        let model = ChallengePostModel(
            postId: self.post_id,
            bookId: id.filter{$0 != "#"},
            bookUrl: self.files.first ?? "",
            title: self.title,
            content: self.content,
            deadLine: self.transformDeadLine(strDate: self.deadLine),
            limitPerson: self.transformLimitPerson(),
            state: self.roomState,
            nick: self.creator.nick
        )
        return model
    }
    private func transformDeadLine(strDate: String) -> String {
        let now = Date()
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: strDate)
        guard let date else {return ""}
        let calender = Calendar.current
        let nowYear = calender.component(.year, from: now)
        let dateYear = calender.component(.year, from: date)
        let difference = Calendar.current.dateComponents([.day], from: now, to: date).day ?? 35
        
        if difference <= 30 {
            return  "D+\(difference)"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            if nowYear == dateYear {
                formatter.dateFormat = "~ M.d"
            }else{
                formatter.dateFormat = "~ yy.M.d"
            }
            let formattedDate = formatter.string(from: date)
            
            return formattedDate
        }

    }
    private func transformLimitPerson() -> String {
        let limit = self.limitPerson //제한한 사항
        let state = self.likes.count//현재 상황
        return "\(state)/\(limit)"
    }
}


