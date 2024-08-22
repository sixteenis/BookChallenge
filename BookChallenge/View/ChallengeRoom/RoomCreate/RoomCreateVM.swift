//
//  RoomCreateVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/19/24.
//

import UIKit
import RxSwift
import RxCocoa

class RoomCreateVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    var bookDTO: BookDTO?
    struct Input {
        let getbookId: PublishSubject<String>
        let datePickerTap: ControlProperty<Date>
        let limitPeople: ControlProperty<String>
        let roomTitle: ControlProperty<String>
        let roomContent: ControlProperty<String>
        let saveButtonTap: Observable<Data?>
    }
    struct Output {
        let bookInfor: Observable<BookModel>
        let isSaveTap: Observable<Bool>
        let netwrokErr: Observable<AlertErrProtocol>
        let finshNetwork: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let bookInfor = PublishSubject<BookModel>()
        let successNetWork = BehaviorRelay(value: false)
        let datePicker = PublishRelay<Date>()
        let limitPeople = BehaviorRelay(value: "")
        let roomTitle = BehaviorRelay(value: "")
        let roomContent = BehaviorRelay(value: "")
        let saveButtonTap = PublishRelay<Void>()
        
        // MARK: - 통신 부분
        let netwrokErr = PublishRelay<AlertErrProtocol>()
        let successImage = BehaviorRelay(value: [String]())
        let successPost = BehaviorRelay(value: "")
        let finshNetwork = PublishRelay<Void>()
        let isSaveEnable = Observable.combineLatest(successNetWork, limitPeople, roomTitle, roomContent)
            .map { success, people, title, content in
                let num = Int(people)
                guard let num else {return false}
                let numResult = 2 <= num && num <= 20
                return success && !title.isEmpty && !content.isEmpty && numResult
            }//북 데이터 값이 있는지, 텍스트들이 다 들어있는지 판단하기
        
        input.getbookId
            .flatMap { AladinManager.shared.getBookDetail(id: $0)}
            .bind(with: self) { owner, result in
                switch result {
                case .success(let book):
                    bookInfor.onNext(BookModel(dto: book))
                    owner.bookDTO = book
                    successNetWork.accept(true)
                    // TODO: 디테일 책 가져오는 과정에서 오류 발생 시 예외처리 해주기
                case .failure(let error):
                    successNetWork.accept(false)
                }
            }.disposed(by: disposeBag)
        input.datePickerTap
            .distinctUntilChanged()
            .bind(to: datePicker).disposed(by: disposeBag)
        input.roomTitle
            .distinctUntilChanged()
            .bind(to: roomTitle).disposed(by: disposeBag)
        input.roomContent
            .distinctUntilChanged()
            .bind(to: roomContent).disposed(by: disposeBag)
        input.limitPeople
            .distinctUntilChanged()
            .bind(to: limitPeople).disposed(by: disposeBag)
        input.saveButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map {
                guard let image = $0 else {return Data()}
                return image
            }
            .flatMap {
                LSLPNetworkManager.shared.request(target: .imagePost(image: .init(files: $0)), dto: ImagePostDTO.self)
            }
            .subscribe(with: self) { owner, respons in
                switch respons {
                case .success(let respons):
                    successImage.accept(respons.files)
                case .failure(let err):
                    netwrokErr.accept(err)
                }
            }.disposed(by: disposeBag)
        
        successImage
            .flatMap {
                
                LSLPNetworkManager.shared.request(target: .contentPost(content: ContentPostBody(book: self.bookDTO ?? BookDTO(title: "", author: "", pubDate: "", description: "", isbn13: "", cover: "", publisher: "", priceSales: 1, subInfo: SubInfo(itemPage: nil, subTitle: nil)), title: roomTitle.value, deadLine: limitPeople.value, limitPreson: Int(limitPeople.value) ?? 0, content: roomContent.value, files: $0)), dto: ContentPostDTO.self)
            }
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let data):
                    successPost.accept(data.post_id)
                case .failure(let err):
                    netwrokErr.accept(err)
                    
                }
                
            }.disposed(by: disposeBag)
        successPost
            .flatMap {
                LSLPNetworkManager.shared.request(target: .like(body: .init(like_status: false), postId: $0), dto: LikeDTO.self)
            }
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(_):
                    finshNetwork.accept(())
                case .failure(let err):
                    netwrokErr.accept(err)
                }
                
            }.disposed(by: disposeBag)
            
        
        
        return Output(bookInfor: bookInfor, isSaveTap: isSaveEnable, netwrokErr: netwrokErr.asObservable(), finshNetwork: finshNetwork.asObservable())
    }
    
}
