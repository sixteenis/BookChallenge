//
//  ChallengeRoomVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/24/24.
//

import Foundation
import RxSwift
import RxCocoa

class ChallengeRoomVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let network = LSLPNetworkManager.shared
    var roomNetworkType = RoomSearchType.all
    
    struct Input {
        let viewDidLoadRx: Observable<Void>
        let searchBookId: PublishSubject<String>
    }
    struct Output {
        let challengeRoomLists: Observable<[ChallengePostModel]>
    }
    func transform(input: Input) -> Output {
        let roomLists = PublishSubject<[ChallengePostModel]>()
        
        input.viewDidLoadRx
            .flatMap { 
                self.network.request(target: .fetchPosts(query: .init(next: "")), dto: FetchPostsDTO.self)
            }
            .bind(with: self) { owner, response in
                print(response)
                switch response {
                case .success(let rooms):
                    let result = rooms.data.filter {$0.roomState != RoomState.close}.filter { $0.creator.user_id != UserManager.shared.userId}.map{$0.transformChallengePostModel()}
                    roomLists.onNext(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        input.searchBookId
            .flatMap {
                self.network.request(target: .hashtagsPoosts(query: .init(next: "", hashTag: $0)), dto: HashtagPostDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let rooms):
                    let result = rooms.data.filter {$0.roomState != RoomState.close}.map{$0.transformChallengePostModel()}
                    roomLists.onNext(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        return Output(challengeRoomLists: roomLists)
    }
}
