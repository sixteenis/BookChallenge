//
//  ShowTopBookVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

class MainVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let books = AladinManager.shared.getBestseller()
    private let network = LSLPNetworkManager.shared
    struct Input {
        let viewdidLoadRx: Observable<()>
    }
    struct Output {
        let bestBookData: BehaviorRelay<[BookDTO]>
        let challengeRoomList: Observable<[ChallengePostModel]>
    }
    func transform(input: Input) -> Output {
        let bestBookData = BehaviorRelay(value: [BookDTO]())
        let challengeRoomLists = PublishSubject<[ChallengePostModel]>()
        self.books.subscribe(with: self) { owner, respons in
            switch respons {
            case .success(let books):
                bestBookData.accept(books)
            case .failure(let err):
                print(err)
            }
        }.disposed(by: disposeBag)
        input.viewdidLoadRx
            .flatMap {
                self.network.request(target: .fetchPosts(query: .init(next: "")), dto: FetchPostsDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    let result = data.data.filter {$0.creator.user_id != UserManager.shared.userId}.filter{$0.roomState != RoomState.close} .map { $0.transformChallengePostModel()}
                    challengeRoomLists.onNext(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        
        return Output(bestBookData: bestBookData, challengeRoomList: challengeRoomLists)

    }
}
