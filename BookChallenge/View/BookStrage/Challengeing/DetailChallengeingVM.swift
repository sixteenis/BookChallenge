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
//        let bottomSheetNetwork: PublishSubject<Void>
        
    }
    struct Output {
        let postInfo: Observable<DetailRoomModel>
    }
    func transform(input: Input) -> Output {
        let postInfo = PublishSubject<DetailRoomModel>()
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
        
        return Output(postInfo: postInfo.asObserver())
    }
}

private extension DetailChallengeingVM {
    //func setUserData(_ data: RoomPostDTO)
}
