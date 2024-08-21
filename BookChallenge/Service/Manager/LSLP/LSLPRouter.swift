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
    var needsToken: Bool { get }
}

enum LSLPRouter {
    case validationEamil(email: ValidationEmailBody)
    case login(login: LoginBody)
    case refresh(token: String)
    case imagePost(image: ImagePostBody)
    case contentPost(content: ContentPostBody)
    case imgeLoad(imagePath: String)
}

extension LSLPRouter: CatchErrorTargetType {
    var baseURL: URL {
        URL(string: LSLP.baseURL + "v1")!
    }
    var path: String {
        switch self {
        case .validationEamil:
            return "/validation/email"
        case .login:
            return "/users/login"
        case .refresh:
            return "auth/refresh"
        case .imagePost:
            return "/posts/files"
        case .contentPost:
            return "/posts"
        case .imgeLoad:
            return "아직 안함"
        }
    }
    var method: Moya.Method {
        switch self {
        case .validationEamil, .login,.imagePost, .contentPost:
            return .post
        default:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .validationEamil(let email):
            return .requestJSONEncodable(email)
        case .login(let login):
            return .requestJSONEncodable(login)
        case .refresh(let refresh):
            return .requestPlain
        case .imagePost(let image):
            let bookjpg = MultipartFormData(provider: .data(image.files), name: "files", fileName: "BookChallenge.jpg", mimeType: "image/jpeg")
            return .uploadMultipart([bookjpg])
        case .contentPost(let content):
            return .requestJSONEncodable(content)
        case .imgeLoad(let imagePath):
            return .requestJSONEncodable(imagePath)
        }
    }
    var headers: [String : String]? {
        switch self {
        case .refresh(let token):
            [
                BaseHeader.sesacKey.rawValue: LSLP.key
            ]
        case .imagePost:
            [
                BaseHeader.contentType.rawValue: BaseHeader.multipart.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key
                
            ]
        default:
            [
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.sesacKey.rawValue: LSLP.key,
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
        case .validationEamil:
            return ValidationEmailDTO.self
        case .login:
            return LoginDTO.self
        case .refresh:
            return RefreshTokeDTO.self
        case .imagePost:
            return ImagePostDTO.self
        case .contentPost:
            return ContentPostDTO.self
        case .imgeLoad:
            return ContentPostDTO.self
        }
    }
    var needsToken: Bool {
        switch self {
        case .login, .validationEamil:
            return false
        default:
            return true
        }
    }
    
}
