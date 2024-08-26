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
    @frozen
    enum RequestType {
        case all
        case bookId
    }
    enum RoomRequestType {
        case first
        case refreshLoading
    }
    private let disposeBag = DisposeBag()
    private let network = LSLPNetworkManager.shared
    
    struct Input {
        let searchBookId: PublishSubject<String>
        let pagination: ControlEvent<[IndexPath]>
        let refreshing: ControlEvent<Void>
    }
    struct Output {
        let challengeRoomLists: Observable<[ChallengePostModel]>
        let refreshLoading: Observable<Bool>
    }
    func transform(input: Input) -> Output {
        let nextCursor = BehaviorRelay(value: "") // 페이지네이션 값 저장
        let bookId = BehaviorRelay(value: "") //책 id 값 받아오기
        let roomLists = BehaviorRelay(value: [ChallengePostModel]()) //뷰에 보여줄 리스트들
        
        let requestAll = BehaviorRelay(value: RoomRequestType.first) //전체 책 통신
        let requestBookId = PublishRelay<Void>() //id값을 통한 통신
        let requestRequired = BehaviorSubject<Bool>(value: false) //페이지 네이션 시작하기
        let requestType = BehaviorSubject(value: RequestType.all)
        
        let refreshLoading = BehaviorSubject(value: false)
        let limiteRefresh = BehaviorRelay(value: false)
        
        Observable<Int>.timer(.seconds(1), period: .seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                limiteRefresh.accept(true)
            }).disposed(by: disposeBag)
        
        requestAll //전체 챌린지 방 가져오기
            .flatMap { _ in self.network.request(target: .fetchPosts(query: .init(next: nextCursor.value)), dto: FetchPostsDTO.self) }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let rooms):
                    let result = rooms.data.filter {$0.roomState != RoomState.close}.map{$0.transformChallengePostModel()}
                    if nextCursor.value == "" {
                        roomLists.accept(result)
                    }else{
                        var befor = roomLists.value
                        befor.append(contentsOf: result)
                        roomLists.accept(befor)
                    }
                    nextCursor.accept(rooms.next_cursor)
                    if requestAll.value == .refreshLoading {
                        refreshLoading.onNext(true)
                    }
                    
                case .failure(let err):
                    if requestAll.value == .refreshLoading {
                        //토스트로 띄어주기
                        refreshLoading.onNext(false)
                    }else{
                        print(err)
                    }
                }
            }.disposed(by: disposeBag)
        
        requestBookId //책 id를 통해 방 가져오기
            .flatMap { _ in self.network.request(target: .hashtagsPoosts(query: .init(next: nextCursor.value, hashTag: bookId.value)), dto: HashtagPostDTO.self) }
            .bind(with: self) { owner, response in
                limiteRefresh.accept(true) //책을 검색했으면 리로딩하는거 타임 초기화해주기
                switch response {
                case .success(let rooms):
                    let result = rooms.data.filter {$0.roomState != RoomState.close}.map{$0.transformChallengePostModel()}
                    if nextCursor.value == "" {
                        roomLists.accept(result)
                    }else{
                        var befor = roomLists.value
                        befor.append(contentsOf: result)
                        roomLists.accept(befor)
                    }
                    nextCursor.accept(rooms.next_cursor)
                    
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        
        
        input.searchBookId //책 검새 후 책id를 통해 챌린지 방 보여주기
            .bind(with: self) { owner, id in
                bookId.accept(id)
                nextCursor.accept("")
                requestBookId.accept(())
            }.disposed(by: disposeBag)
        
        
        
        input.pagination //페이지네이션 판별하기
            .map {
                for index in $0 {
                    if index.item == roomLists.value.count - 1 && nextCursor.value != "0" { return true }
                }
                return false
            }
            .filter { $0 }
            .bind(with: self) { owner, value in
                requestRequired.onNext(value)
            }.disposed(by: disposeBag)
        
        requestRequired
            .filter {$0}
            .withLatestFrom(requestType)
            .bind(with: self) { owner, type in
                switch type {
                case .all:
                    requestAll.accept(.first)
                    
                case .bookId:
                    requestBookId.accept(())
                }
            }.disposed(by: disposeBag)
        
        input.refreshing
            .bind(with: self) { owner, _ in
                if limiteRefresh.value {
                    nextCursor.accept("")
                    requestAll.accept(.refreshLoading)
                    limiteRefresh.accept(false)
                } else {
                    refreshLoading.onNext(false)
                }
                
                
            }.disposed(by: disposeBag)
        
        return Output(challengeRoomLists: roomLists.asObservable(), refreshLoading: refreshLoading)
    }
}
