//
//  DetailChallengeingVM.swift
//  BookChallenge
//
//  Created by 박성민 on 10/19/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailChallengeingVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    var roomData: BookRoomModel!
    private let network = LSLPNetworkManager.shared
    struct Input {
        let viewWillAppear: Observable<Void>
        let removeTap: PublishSubject<Void>
//        let bottomSheetNetwork: PublishSubject<Void>
        
    }
    struct Output {
        let postInfo: Observable<DetailRoomModel>
        let successRemove: Observable<Bool>
    }
    func transform(input: Input) -> Output {
        let postInfo = PublishSubject<DetailRoomModel>()
        let successRemove = PublishSubject<Bool>()
        input.viewWillAppear
            .flatMap { self.network.request(target: .searchPost(id: self.roomData.postId), dto: RoomPostDTO.self) }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    postInfo.onNext(data.transformDeatilRoomModel())
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        input.removeTap
            .flatMap { self.network.request(target: .like(body: LikeBody(like_status: false), postId: self.roomData.postId), dto: LikeDTO.self)}
            .bind(with: self) { owner, response in
                switch response {
                case .success(_):
                    NotificationCenter.default.post(name: .likePost, object: ())

                    successRemove.onNext(true)
                case .failure(_):
                    successRemove.onNext(false)
                }
            }.disposed(by: disposeBag)
        
        return Output(postInfo: postInfo.asObserver(), successRemove: successRemove.asObserver())
    }
}

private extension DetailChallengeingVM {
    //func setUserData(_ data: RoomPostDTO)
}
