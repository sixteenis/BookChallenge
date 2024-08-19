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
    
    struct Input {
        let getbookId: PublishSubject<String>
    }
    struct Output {
        let bookInfor: Observable<BookModel>
    }
    
    func transform(input: Input) -> Output {
        let bookInfor = PublishSubject<BookModel>()
        input.getbookId
            .flatMap { AladinManager.shared.getBookDetail(id: $0)}
            .bind(with: self) { owner, result in
                switch result {
                case .success(let book):
                    bookInfor.onNext(BookModel(dto: book))
                // TODO: 디테일 책 가져오는 과정에서 오류 발생 시 예외처리 해주기
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        return Output(bookInfor: bookInfor)
    }
    
}
