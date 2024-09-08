//
//  ShowTopBookVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MainVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let books = AladinManager.shared.getBestseller()
    private let network = LSLPNetworkManager.shared
    struct Input {
        let viewdidLoadRx: Observable<()>
    }
    struct Output {
        let bestBookData: BehaviorRelay<[BookDTO]>
        let challengeingList: Observable<[BookRoomModel]>
        let challengeRoomList: Observable<[ChallengePostModel]>
        let isLoading: BehaviorRelay<Bool>
    }
    func transform(input: Input) -> Output {
        let bestBookData = BehaviorRelay(value: [BookDTO]())
        let challengeingList = PublishSubject<[BookRoomModel]>()
        let challengeRoomLists = PublishSubject<[ChallengePostModel]>()
        let isLoading = BehaviorRelay(value: true)
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.books.subscribe(with: self) { owner, respons in
            switch respons {
            case .success(let books):
                bestBookData.accept(books)
            case .failure(let err):
                print(err)
            }
            dispatchGroup.leave()
        }.disposed(by: disposeBag)
        dispatchGroup.enter()
        input.viewdidLoadRx
            .flatMap { self.network.request(target: .getLikePosts(query: .init()), dto: LikePostsDTO.self)}
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    let result = data.data.map {$0.transformBookRoomModel()}
                    challengeingList.onNext(result)
                case .failure(let err):
                    print(err)
                }
                dispatchGroup.leave()
            }.disposed(by: disposeBag)
        dispatchGroup.enter()
        input.viewdidLoadRx
            .flatMap {
                self.network.request(target: .fetchPosts(query: .init(next: "")), dto: FetchPostsDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    let result = data.data.filter{$0.roomState != RoomState.close && $0.checkDate()} .map { $0.transformChallengePostModel()}
                    challengeRoomLists.onNext(result)
                case .failure(let err):
                    print(err)
                }
                dispatchGroup.leave()
            }.disposed(by: disposeBag)
        
        
        dispatchGroup.notify(queue: .main) {
            isLoading.accept(false)
        }
        
        return Output(bestBookData: bestBookData, challengeingList: challengeingList, challengeRoomList: challengeRoomLists, isLoading: isLoading)

    }
}
