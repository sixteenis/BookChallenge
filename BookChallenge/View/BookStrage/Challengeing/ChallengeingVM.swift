//
//  ChallengeingVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/29/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ChallengeingVM: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    struct Input {
        let viewdidLoadRx: Observable<Void>
    }
    struct Output {
        let challnegeingData: Observable<[BookRoomModel]>
    }
    func transform(input: Input) -> Output {
        let roomData = BehaviorRelay(value: [BookRoomModel]())
        let reloading = PublishRelay<Void>()
        input.viewdidLoadRx
            .flatMap { LSLPNetworkManager.shared.request(target: .getLikePosts(query: .init()), dto: LikePostsDTO.self)}
            .bind(with: self) { owner, response in
                
                switch response {
                case .success(let data):
                    let result = data.data.map { $0.transformBookRoomModel()}
                    roomData.accept(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        reloading //다른 뷰에서 신호를 주면 받아서 데이터 리로딩
            .flatMap { LSLPNetworkManager.shared.request(target: .getLikePosts(query: .init()), dto: LikePostsDTO.self)}
            .bind(with: self) { owner, response in
                
                switch response {
                case .success(let data):
                    
                    let result = data.data.map { $0.transformBookRoomModel()}
                    
                    roomData.accept(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(.likePost) //챌린지 참여할 경우 리로딩
            .asDriver(onErrorRecover: {_ in .never()})
            .drive(with: self) { owner, _ in
                reloading.accept(())
            }.disposed(by: disposeBag)
        return Output(challnegeingData: roomData.asObservable())
    }
}
