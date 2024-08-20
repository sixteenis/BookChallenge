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
        let roomTitle: ControlProperty<String>
        let roomContent: ControlProperty<String>
        let saveButtonTap: Observable<Data?>
    }
    struct Output {
        let bookInfor: Observable<BookModel>
        let isSaveTap: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let bookInfor = PublishSubject<BookModel>()
        let successNetWork = BehaviorRelay(value: false)
        let datePicker = PublishRelay<Date>()
        let roomTitle = BehaviorRelay(value: "")
        let roomContent = BehaviorRelay(value: "")
        let saveButtonTap = PublishRelay<Void>()
        
        let isSaveEnable = Observable.combineLatest(successNetWork, roomTitle, roomContent)
            .map { success, title, content in
                return success && !roomTitle.value.isEmpty && !roomContent.value.isEmpty
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
                    print(error)
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
        
        input.saveButtonTap
            .bind(with: self) { owner, image in
                guard let image else {return}
                LSLPNetworkManger.shared.createChallengeRoom(book: owner.bookDTO!, title: roomTitle.value, content: roomContent.value, date: "2024820", files: image)
            }.disposed(by: disposeBag)
        
        
        
        return Output(bookInfor: bookInfor, isSaveTap: isSaveEnable)
    }
    
}
