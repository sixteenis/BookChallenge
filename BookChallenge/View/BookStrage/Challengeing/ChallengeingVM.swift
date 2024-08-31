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
        let bottomSheetNetwork: PublishSubject<Void>
    }
    struct Output {
        let challnegeingData: Observable<[BookRoomModel]>
    }
    func transform(input: Input) -> Output {
        let roomData = BehaviorRelay(value: [BookRoomModel]())
        let networkingStart = BehaviorRelay(value: true)
        networkingStart
            .filter {$0}
            .flatMap { _ in
                LSLPNetworkManager.shared.request(target: .getLikePosts(query: .init()), dto: LikePostsDTO.self)
            }
            .bind(with: self) { owner, response in
                print("통신함!!!!!")
                networkingStart.accept(false)
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
                networkingStart.accept(true)
            }.disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(.makePost) //챌린지 방만들경우 리로딩
            .asDriver(onErrorRecover: {_ in .never()})
            .drive(with: self) { owner, _ in
                networkingStart.accept(true)
            }.disposed(by: disposeBag)
        input.bottomSheetNetwork
            .bind(with: self) { owner, _ in
                networkingStart.accept(true)
            }.disposed(by: disposeBag)
        
        
        return Output(challnegeingData: roomData.asObservable())
    }
}
