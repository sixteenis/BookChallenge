//
//  PostManger.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import Alamofire
import RxSwift
//rxcocoa -> 프리패치 아이패스 쓰기
//한번만 호출하게 만들기
//alamofire 리트라이 써보기!
final class PostManger {
    static let shared = PostManger()
    private init() {}
//    func uploadPostFiles<T: Decodable>(data: Data, type: T) -> Single<NetworkResult<T>>{
//        return Single.create { observer -> Disposable in
//            let request = try! PostRouter.uploadPostFiles.asURLRequest()
//            AF.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(data, withName: "files", fileName: "BookChallenge.jpg", mimeType: "image/jpeg")
//            }, with: request)
//            .responseDecodable(of: T.self) { response in
//                switch response.result {
//                case .success(let data):
//                    observer(.success(.success(data))
//                case .failure(let error) {
//                    observer(.success(.failure(error)))
//                }
//                }
//            }
//            
//            
//        }
        //            let request = try! PostRouter.uploadPostFiles.asURLRequest()
        //            AF.upload(multipartFormData: { multipartFormData in
        //                multipartFormData.append(data, withName: "files", fileName: "BookChallenge.jpg", mimeType: "image/jpeg")
        //            }, with: request)
        //            .responseDecodable(of: FilesDTO.self) { response in
        //                if response.response?.statusCode == 419 {
        //                    LSLPUserManager.shared.refreshToke {
        //                        self.uploadPostFiles(data: data)
        //                    }
        //                }
        //                switch response.result {
        //                case .success(let data):
        //                    completion?(data)
        //                case .failure(let error):
        //                    print("포스트 이미지 실패 ㅠ")
        //                    print(error)
        //                }
        //            }
        
        
        
//    }
//    func uploadPostContent(book: BookDTO, title: String, content: String, date: String, file: FilesDTO) {
//        do {
//            let body = UploadPostContentsBody.init(book: book, title: title, content: content, date: date, files: file)
//            let request = try PostRouter.uploadPostContents(body: body).asURLRequest()
//            AF.request(request)
//                .responseDecodable(of: PostDTO.self) { response in
//                    if response.response?.statusCode == 419 {
//                        LSLPUserManager.shared.refreshToke {
//                            self.uploadPostContent(book: book, title: title, content: content, date: date, file: file)
//                        }
//                    }
//                    switch response.result {
//                    case .success(let data):
//                        print(data)
//                    case .failure(let error):
//                        print(response.response?.statusCode)
//                        print("포스트 실패 ㅠ")
//                        print(error)
//                    }
//                }
//            
//        } catch {
//            print("포스트 컨텐츠 통신 오류!")
//        }
//    }
    
    
    
}
