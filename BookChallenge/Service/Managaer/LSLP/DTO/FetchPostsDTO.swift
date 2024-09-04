//
//  FetchPosts.swift
//  BookChallenge
//
//  Created by 박성민 on 8/22/24.
//

import Foundation

struct FetchPostsQuery: Encodable {
    let next: String
    let limit: String = "10"
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
    let comments: [CommentsDTO]
    let createdAt: String
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
        case comments
        case createdAt
    }
    func transformBookRoomModel() -> BookRoomModel {
        let title = self.title.split(separator: "]").map(String.init)
        let nowPage = self.comments.filter {$0.creator.user_id == UserManager.shared.userId}.first?.content.split(separator: UserManager.shared.userId).map(String.init)[0]
        let fiterPageInt = nowPage ?? "0"
        let totalDate = Date.comparisonDate(to: Date.asTranformDate(str: self.createdAt), form: Date.asTranformDate(str: self.deadLine)) + 1
        let nowDate = Date.comparisonDate(to: Date.asTranformDate(str: self.createdAt), form: Date()) + 1
        let model = BookRoomModel(
            postId: self.post_id,
            bookurl: self.files[0],
            bookTitle: title[0],
            booktotalPage: Int(self.page) ?? 0,
            bookNowPage: Int(fiterPageInt) ?? 0,
            startDate: Date.asTransformCustomStr(str: self.createdAt),
            endDate: Date.asTransformCustomStr(str: self.deadLine),
            totalDate: totalDate,
            nowDate: nowDate
        )
        return model
    }
    func transformChallengePostModel() -> ChallengePostModel {
        let title = self.title.split(separator: "]").map(String.init)
        let model =  ChallengePostModel(
            profile: self.creator.profileImage,
            postId: self.post_id,
            bookId: id.filter{ $0 != "#"},
            bookUrl: self.files.first ?? "",
            title: title[1],
            bookTitle: title[0],
            content: self.content,
            deadLine: self.transformDeadLine(strDate: self.deadLine),
            limitPerson: self.transformLimitPerson(),
            state: self.roomState,
            nick: self.creator.nick
        )
        return model
    }
    // MARK: - 현재 시간 기준 마감된 방인지 파악하는 함수
    func checkDate() -> Bool {
        let deadDate = Date.asTranformDate(str: self.deadLine)
        let isdead = Date.comparisonDate(to: Date(), form: deadDate)
        return isdead >= 0
    }
    private func transformDeadLine(strDate: String) -> String {
        let now = Date()
        let compareDate = Date.asTranformDate(str: strDate)
        
        let calender = Calendar.current
        let nowYear = calender.component(.year, from: now)
        let dateYear = calender.component(.year, from: compareDate)
        let compare = Date.comparisonDate(to: now, form: compareDate)
        if compare <= 30 {
            if compare == 0 {
                return "오늘 종료"
            }
            return  "D+\(compare)"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            if nowYear == dateYear {
                formatter.dateFormat = "~ M.d"
            }else{
                formatter.dateFormat = "~ yy.M.d"
            }
            let formattedDate = formatter.string(from: compareDate)
            
            return formattedDate
        }

    }

    private func transformLimitPerson() -> String {
        let limit = self.limitPerson //제한한 사항
        let state = self.likes.count//현재 상황
        return "\(state)/\(limit)"
    }
}


