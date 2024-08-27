//
//  ChallengeDetailVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/26/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ChallengeDetailVM: BaseViewModel {
    var inputData = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    struct Input {
        let joinButtonTap: Observable<Void>
    }
    struct Output {
        let bookData: Observable<BookModel>
        let postData: Observable<ChallengePostModel>
        let retrunBeforeErr: Observable<String>
        let joinSuccess: Observable<Void>
    }
    func transform(input: Input) -> Output {
        let bookData = PublishRelay<BookModel>()
        let postData = PublishRelay<ChallengePostModel>()
        let bookId = PublishRelay<String>()
        let postId = BehaviorRelay(value: "")
        let retrunBeforeErr = PublishRelay<String>()
        let joinSuccess = PublishRelay<Void>()
        inputData
            .compactMap { $0 }
            .flatMap {
                print("----")
                print($0)
                print("----")
                return LSLPNetworkManager.shared.request(target: .searchPost(id: $0), dto: RoomPostDTO.self)
            }
            .bind(with: self) { owner, respons in
                switch respons {
                case .success(let dto):
                    if dto.roomState == RoomState.close {
                        retrunBeforeErr.accept("삭제된 챌린지 방입니다.")
                    } else if dto.likes.contains(UserManager.shared.userId) {
                        retrunBeforeErr.accept("이미 참여 중인 챌린지입니다.")
                    } else if dto.likes.count >= Int(dto.limitPerson)! {
                        retrunBeforeErr.accept("참여 인원이 초과되었습니다.")
                    }
                    else {
                        let model = dto.transformChallengePostModel()
                        postData.accept(model)
                        bookId.accept(model.bookId)
                        postId.accept(model.postId)
                    }
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        bookId
            .flatMap {
                print($0)
                return AladinManager.shared.getBookDetail(id: $0) }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    bookData.accept(data.transformBookModel())
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        input.joinButtonTap
            .withLatestFrom(postId)
            .flatMap { LSLPNetworkManager.shared.request(target: .like(body: .init(like_status: true), postId: $0), dto: LikeDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(_):
                    joinSuccess.accept(())
                    NotificationCenter.default.post(name: .likePost, object: postId.value)
                case .failure(let err):
                    print(err)
                    
                }
            }.disposed(by: disposeBag)
        
        
        return Output(bookData: bookData.asObservable(), postData: postData.asObservable(), retrunBeforeErr: retrunBeforeErr.asObservable(), joinSuccess: joinSuccess.asObservable())
    }
}
