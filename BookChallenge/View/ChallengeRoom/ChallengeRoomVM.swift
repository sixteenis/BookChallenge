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
        let scrollTop: Observable<Void>
        let isLoading: Observable<Bool>
    }
    func transform(input: Input) -> Output {
        let nextCursor = BehaviorRelay(value: "") // 페이지네이션 값 저장
        let bookId = BehaviorRelay(value: "") //책 id 값 받아오기
        let roomLists = BehaviorRelay(value: [ChallengePostModel]()) //뷰에 보여줄 리스트들
        
        let requestAll = BehaviorRelay(value: RoomRequestType.first) //전체 책 통신
        let requestBookId = PublishRelay<Void>() //id값을 통한 통신
        let requestRequired = BehaviorSubject<Bool>(value: false) //페이지 네이션 시작하기
        let requestType = BehaviorRelay(value: RequestType.all)
        
        let refreshLoading = BehaviorSubject(value: false)
        let limiteRefresh = BehaviorRelay(value: false)
        let scrollTop = PublishSubject<Void>()
        
        let isLoading = PublishSubject<Bool>() //로딩화면 띄워줄지 말지
        let refreshOnlyOneRoom = PublishSubject<(Int,String)>()
        Observable<Int>.timer(.seconds(1), period: .seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                limiteRefresh.accept(true)
            }).disposed(by: disposeBag)
        
        requestAll //전체 챌린지 방 가져오기
            .flatMap { _ in
                isLoading.onNext(true)
                return self.network.request(target: .fetchPosts(query: .init(next: nextCursor.value)), dto: FetchPostsDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let room):
                    let result = owner.filterModel(dto: room.data)
                    if nextCursor.value == "" {
                        roomLists.accept(result)
                    }else{
                        var befor = roomLists.value
                        befor.append(contentsOf: result)
                        roomLists.accept(befor)
                    }
                    nextCursor.accept(room.next_cursor)
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
                isLoading.onNext(false)
            }.disposed(by: disposeBag)
        
        requestBookId //책 id를 통해 방 가져오기
            .flatMap { _ in
                isLoading.onNext(true)
                return self.network.request(target: .hashtagsPoosts(query: .init(next: nextCursor.value, hashTag: bookId.value)), dto: HashtagPostDTO.self) }
            .bind(with: self) { owner, response in
                limiteRefresh.accept(true) //책을 검색했으면 리로딩하는거 타임 초기화해주기
                switch response {
                    
                case .success(let room):
                    let result = owner.filterModel(dto: room.data)
                    if nextCursor.value == "" {
                        roomLists.accept(result)
                        if !result.isEmpty {
                            scrollTop.onNext(())
                        }
                        
                    }else{
                        var befor = roomLists.value
                        befor.append(contentsOf: result)
                        roomLists.accept(befor)
                    }
                    nextCursor.accept(room.next_cursor)
                    
                case .failure(let err):
                    print(err)
                }
                isLoading.onNext(false)
                
            }.disposed(by: disposeBag)
        // MARK: - 중복되는거 같음 로직 다시 짜삼 나중에
//        roomLists
//            .bind(with: self) { owner, room in
//                if 0 < room.count && room.count < 4 && nextCursor.value != "0"{
//                    switch requestType.value {
//                    case .all:
//                        requestAll.accept(.refreshLoading)
//                    case .bookId:
//                        requestBookId.accept(())
//                    }
//                }
//            }.disposed(by: disposeBag)
        
        
        input.searchBookId //책 검색 후 책id를 통해 챌린지 방 보여주기
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
        NotificationCenter.default.rx.notification(.likePost)
            .asDriver(onErrorRecover: {_ in .never()})
            .drive(with: self) { owner, postId in
                guard let postId = postId.object as? String else { return }
                let result = owner.checkPostId(modles: roomLists.value, id: postId)
                let list = roomLists.value
                if self.checkPostId(modles: roomLists.value, id: postId) {
                    if let index = list.firstIndex(where: {$0.postId == postId}) {
                        refreshOnlyOneRoom.onNext((index, postId))
                    }
                }
            }.disposed(by: disposeBag)
        //안쓸거같음. 방을 리로딩 안해도될듯
        refreshOnlyOneRoom
            .flatMap { LSLPNetworkManager.shared.request(target: .searchPost(id: $0.1), dto: RoomPostDTO.self)}
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    print("")
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        return Output(challengeRoomLists: roomLists.asObservable(), refreshLoading: refreshLoading, scrollTop: scrollTop, isLoading: isLoading)
    }
    private func checkPostId(modles: [ChallengePostModel], id: String) -> Bool {
        let filter = modles.filter { $0.postId == id }
        guard let data = filter.first else { return false }
        
        return true
    }
    private func filterModel(dto: [RoomPostDTO]) ->  [ChallengePostModel] {
        let result = dto.filter { model in
            return model.roomState != RoomState.close && model.checkDate()
         }
        return result.map { $0.transformChallengePostModel() }
        
    }
}

