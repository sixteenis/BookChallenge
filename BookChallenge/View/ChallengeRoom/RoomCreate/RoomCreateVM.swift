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
    var bookModel = BookModel.init()
    struct Input {
        let getbook: PublishSubject<BookModel>
        let datePickerTap: ControlProperty<Date>
        let limitPeople: ControlProperty<String>
        let roomTitle: ControlProperty<String>
        let roomContent: ControlProperty<String>
        let saveButtonTap: Observable<Data>
    }
    struct Output {
        let bookInfor: Observable<BookModel>
        let isSaveTap: Observable<Bool>
        let netwrokErr: Observable<LoggableError>
        let finshNetwork: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let bookData = PublishSubject<BookModel>()
        let successNetWork = BehaviorRelay(value: false)
        let datePicker = BehaviorRelay(value: Date())
        let limitPeople = BehaviorRelay(value: "")
        let roomTitle = BehaviorRelay(value: "")
        let roomContent = BehaviorRelay(value: "")
        
        let saveButtonTap = PublishRelay<Void>()
        
        // MARK: - 통신 부분
        let netwrokErr = PublishRelay<LoggableError>()
        let successImage = PublishRelay<[String]>()
        let successPost = PublishRelay<String>()
        let finshNetwork = PublishRelay<Void>()
        let isSaveEnable = Observable.combineLatest(successNetWork, limitPeople, roomTitle, roomContent)
            .map { success, people, title, content in
                let num = Int(people)
                guard let num else {return false}
                let numResult = 2 <= num && num <= 20
                return success && !title.isEmpty && !content.isEmpty && numResult
            }//북 데이터 값이 있는지, 텍스트들이 다 들어있는지 판단하기
        
        input.getbook
            .flatMap { AladinManager.shared.getBookDetail(id: $0.id)}
            .bind(with: self) { owner, result in
                switch result {
                case .success(let book):
                    //bookData.bind(book.transformBookModel())
                    let bookModel = book.transformBookModel()
                    bookData.onNext(bookModel)
                    owner.bookModel = bookModel
                    successNetWork.accept(true)
                case .failure(let error):
                    successNetWork.accept(false)
                    netwrokErr.accept(error)
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
                LSLPNetworkManager.shared.request(target: .contentPost(content: .init(book: self.bookModel, title: "\(self.bookModel.title)]" + roomTitle.value, deadLine: Date.asTransformString(date: datePicker.value), limitPreson: limitPeople.value, content: roomContent.value, files: $0)), dto: ContentPostDTO.self)
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
                LSLPNetworkManager.shared.request(target: .like(body: .init(like_status: true), postId: $0), dto: LikeDTO.self)
            }
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(_):
                    NotificationCenter.default.post(name: .makePost, object: ())
                    finshNetwork.accept(())
                case .failure(let err):
                    netwrokErr.accept(err)
                }
                
            }.disposed(by: disposeBag)
        
        
        
        return Output(bookInfor: bookData, isSaveTap: isSaveEnable, netwrokErr: netwrokErr.asObservable(), finshNetwork: finshNetwork.asObservable())
    }
    
}
