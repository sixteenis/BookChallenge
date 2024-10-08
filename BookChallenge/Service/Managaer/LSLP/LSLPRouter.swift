//
//  LSLPRouter.swift
//  BookChallenge
//
//  Created by 박성민 on 8/21/24.
//

import Foundation
import Moya

protocol CatchErrorTargetType: TargetType {
    var resultModel: Decodable.Type { get }
}

enum LSLPRouter {
    case join(join: JoinBody) //회원가입
    case validationEamil(email: ValidationEmailBody) //이메일 중복 확인
    case login(login: LoginBody) //로그인
    case refresh //토큰 갱신
    case withdraw // 탈퇴
    
    case imagePost(image: ImagePostBody) //포스트 이미지 업로드
    case contentPost(content: ContentPostBody) //포스트 텍스트 업로드
    
    case fetchPosts(query: FetchPostsQuery) // 포스트 최신순으로 가져오기
    case searchPost(id: String) // 포스트 검색
    
    case commentsPost(body: CommentsBody, postId: String) //댓글 달기
    case like(body: LikeBody, postId: String) // 좋아요. 나는 참여하기로 사용
    case getLikePosts(query: LikePostsQuery) // 참여한 방들 조회하기로 사용
    case hashtagsPoosts(query: HashtagPostQuery) //해쉬태그 방조회 나는 책 검색으로 사용할 예정
    case fetchMeProfile
    case validationBuy(body: validationBuyBody)
}

extension LSLPRouter: CatchErrorTargetType {
    var baseURL: URL {
        URL(string: LSLP.baseURL + "v1")!
    }
    var path: String {
        switch self {
        case .join:
            return "/users/join"
        case .validationEamil:
            return "/validation/email"
        case .login:
            return "/users/login"
        case .refresh:
            return "/auth/refresh"
        case .withdraw:
            return "/users/withdraw"
        case .imagePost:
            return "/posts/files"
        case .contentPost:
            return "/posts"
        case .fetchPosts:
            return "/posts"
        case .searchPost(let id): //이거 안쓰는데 쓸거면 수정해야됨!
            return "/posts/\(id)"
        case .commentsPost( _, let id):
            return "/posts/\(id)/comments"
        case .like(_, let id):
            return "/posts/\(id)/like"
        case .getLikePosts:
            return "/posts/likes/me"
        case .hashtagsPoosts:
            return "/posts/hashtags"
        case .fetchMeProfile:
            return "/users/me/profile"
        case .validationBuy:
            return "/payments/validation"
            
            
        }
    }
    var method: Moya.Method {
        switch self {
        case .join, .validationEamil, .login,.imagePost, .contentPost:
            return .post
        case .commentsPost, .like, .validationBuy:
            return .post
        default:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .join(let join):
            return .requestJSONEncodable(join)
        case .validationEamil(let email):
            return .requestJSONEncodable(email)
        case .login(let login):
            return .requestJSONEncodable(login)
        case .refresh:
            return .requestPlain
        case .withdraw:
            return .requestPlain
        case .imagePost(let image):
            let bookjpg = MultipartFormData(provider: .data(image.files), name: "files", fileName: "BookChallenge.jpg", mimeType: "image/jpeg")
            return .uploadMultipart([bookjpg])
        case .contentPost(let content):
            return .requestJSONEncodable(content)
        case .fetchPosts(let query):
                return .requestParameters(parameters:
                                        [
                                            "next" : query.next,
                                            "limit": query.limit,
                                            "product_id": query.product_id
                                        ],
                                      encoding: URLEncoding.queryString)
        case .searchPost:
            return .requestPlain
        case .commentsPost(let body, _):
            return .requestJSONEncodable(body)
        case .like(let body, _):
            return .requestJSONEncodable(body)
        case .getLikePosts(let query):
            return .requestParameters(parameters:
                                    [
                                        "next" : query.next,
                                        "limit": query.limit,
                                    ],
                                  encoding: URLEncoding.queryString)
        case .hashtagsPoosts(let query):
            return .requestParameters(parameters:
                                    [
                                        "next" : query.next,
                                        "limit": query.limit,
                                        "product_id": query.product_id,
                                        "hashTag": query.hashTag
                                    ],
                                  encoding: URLEncoding.queryString)
        case .fetchMeProfile:
            return .requestPlain
        case .validationBuy(let body):
            return .requestJSONEncodable(body)
            
            
        }
    }
    var headers: [String : String]? {
        switch self {
        case .refresh:
            [
                BaseHeader.refresh.rawValue: UserManager.shared.refreshToken,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
        case .imagePost:
            [
                BaseHeader.contentType.rawValue: BaseHeader.multipart.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key
                
            ]
        case .like, .fetchPosts, .hashtagsPoosts, .getLikePosts, .fetchMeProfile, .searchPost, .validationBuy:
            [
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
        default:
            [
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
        }
    }
    var validationType: ValidationType {
        switch self {
        default:
                .successCodes
        }
    }
    var resultModel: Decodable.Type {
        switch self {
        case .join:
            return JoinDTO.self
        case .validationEamil:
            return ValidationEmailDTO.self
        case .login:
            return LoginDTO.self
        case .withdraw:
            return WithdrawDTO.self
        case .refresh:
            return RefreshTokenDTO.self
        case .imagePost:
            return ImagePostDTO.self
        case .contentPost:
            return ContentPostDTO.self
        case .fetchPosts:
            return FetchPostsDTO.self
        case .searchPost:
            return RoomPostDTO.self
        case .commentsPost:
            return CommentsDTO.self
        case .like:
            return LikeDTO.self
        case .getLikePosts:
            return LikePostsDTO.self
        case .hashtagsPoosts:
            return HashtagPostDTO.self
        case .fetchMeProfile:
            return ProfileDTO.self
        case .validationBuy:
            return ValidationBuyDTO.self
        }
    }
    
}
