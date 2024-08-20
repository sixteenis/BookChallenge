//
//  PostRouter.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import Alamofire
enum PostRouter {
    case uploadPostFiles // 포스트 이미지 작성
    case uploadPostContents(body: UploadPostContentsBody) // 포스트 컨텐츠 작성
//    case fetchPosts // 포스트 리스트 가져오기
//    case fetchPostsWithId // 특정 포스트 가져오기
//    case fetchUserPosts // 특정 유저의 작성 포스트 가져오기
//    case commentsChat // 댓글 달기
//    case removeChat // 댓글 지우기
//    case postLike // 포스트 좋아요 누르기
//    case fetchLikePosts // 좋아요 누른 포스트 가져오기
    
    //포스트 수정, 포스트 삭제, 댓글 수정,
}
extension PostRouter: LSLPTargetType {
        var method: Alamofire.HTTPMethod {
        switch self {
        case .uploadPostFiles, .uploadPostContents:
            return .post
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItmes: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
//        case .uploadPostFiles(let body):
//            let encoder = JSONEncoder()
//            return try? encoder.encode(body)
        case .uploadPostContents(let body):
            let encoder = JSONEncoder()
            return try? encoder.encode(body)
        default:
            return nil
        }
        
    }
    
    var baseURL: String {
        return LSLP.baseURL + "v1"
    }
    
    var path: String {
        switch self {
        case .uploadPostFiles:
            return "/posts/files"
        case .uploadPostContents:
            return "/posts"
        
        }
    }
    var header: [String: String] {
        switch self {
        case .uploadPostFiles:
            let header = [
                BaseHeader.contentType.rawValue: BaseHeader.multipart.rawValue,
                BaseHeader.authorization.rawValue: UserManager.shared.token,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
            return header
        case .uploadPostContents:
            let header = [
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.authorization.rawValue: UserManager.shared.token,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
            return header
        }
    }
}
