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
    
    struct Input {
        let viewDidLoadRx: Observable<Void>
        let searchBookId: PublishSubject<String>
        let pagination: ControlEvent<[IndexPath]>
    }
    struct Output {
        let challengeRoomLists: Observable<[ChallengePostModel]>
    }
    func transform(input: Input) -> Output {
        let nextCursor = BehaviorSubject(value: "")
        let listType = BehaviorRelay(value: RoomSearchType.all) //먼저 뷰가 시작하면 전체 리스트보여줌
        let roomLists = BehaviorRelay(value: [ChallengePostModel]()) //뷰에 보여줄 리스트들
        let requestRequired = BehaviorSubject<Bool>(value: false) //페이지 네이션 시작하기
        
//        let requestRequired = BehaviorSubject(value: false)
        let requestAll = BehaviorSubject(value: ())
        let requestBookId = PublishRelay<String>()
        input.viewDidLoadRx //처음 뷰 뜰 때 전체 챌린지 방 보여주기
            .flatMap {
                self.network.request(target: .fetchPosts(query: .init(next: "")), dto: FetchPostsDTO.self)
            }
            .bind(with: self) { owner, response in
                print(response)
                switch response {
                case .success(let rooms):
                    print(rooms.next_cursor)
                    print("------")
                    nextCursor.onNext(rooms.next_cursor)
                    let result = rooms.data.filter {$0.roomState != RoomState.close}.map{$0.transformChallengePostModel()}
                    roomLists.accept(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        input.searchBookId //책 검새 후 책id를 통해 챌린지 방 보여주기
            .flatMap {
                listType.accept(.searchId(hashTag: ""))
                nextCursor.onNext("")
                return self.network.request(target: .hashtagsPoosts(query: .init(next: try! nextCursor.value(), hashTag: $0)), dto: HashtagPostDTO.self)
            }
            .bind(with: self) { owner, response in
                
                switch response {
                case .success(let rooms):
                    nextCursor.onNext(rooms.next_cursor)
                    let result = rooms.data.filter {$0.roomState != RoomState.close}.map{$0.transformChallengePostModel()}
                    roomLists.accept(result)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        input.pagination
            .map {
                for index in $0 {
                    if index.item == roomLists.value.count - 2 {
                        return true
                    }
                }
                return false
            }
            .filter { $0 }
            .bind(with: self) { owner, value in
                print(value)
                requestRequired.onNext(value)
            }.disposed(by: disposeBag)
        
        requestRequired
            .filter {$0}
            .bind(with: self) { owner, _ in
                switch listType.value {
                case .all:
                    requestAll.onNext(())
                case .searchId:
                    requestBookId.accept("ss")
                }
            }.disposed(by: disposeBag)
        
        requestAll
            .withLatestFrom(nextCursor)
            .filter{ $0 != "0"}
            .flatMapLatest { next in
                self.network.request(target: .fetchPosts(query: .init(next: next)), dto: FetchPostsDTO.self)
            }.debug("페이지 네이션")
            .bind(with: self) { owner, response in
                print("이까지는 옴???")
                switch response{
                case .success(let data):
                    nextCursor.onNext(data.next_cursor)
                    var befor = roomLists.value
                    let result = data.data.map {$0.transformChallengePostModel()}
                    befor.append(contentsOf: result)
                    roomLists.accept(befor)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        
        
        return Output(challengeRoomLists: roomLists.asObservable())
    }
}
