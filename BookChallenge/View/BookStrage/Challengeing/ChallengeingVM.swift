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
        return Output(challnegeingData: roomData.asObservable())
    }
}
