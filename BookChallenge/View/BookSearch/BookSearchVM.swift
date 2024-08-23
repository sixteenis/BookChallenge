//
//  BookSearchVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

class BookSearchVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    var compltionBook: ((BookModel) -> ())?
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let tapBook: PublishSubject<BookModel>
    }
    struct Output {
        let bookList: Observable<[BookModel]>
        let successReturnID: Observable<Void>
    }
    func transform(input: Input) -> Output {
        let bookList = PublishSubject<[BookModel]>()
        let succesReturnId = PublishSubject<Void>()
        //let getError = BehaviorRelay<AladinError>()
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap {
                AladinManager.shared.getBookLists(keyword: $0, page: 1)
            }
            .bind(with: self) { owner, respon in
                switch respon {
                case .success(let data):
                    let books = data.item.map { $0.transformBookModel()}
                    bookList.onNext(books)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        input.tapBook
            .bind(with: self) { owner, book in
                owner.compltionBook?(book)
                succesReturnId.onNext(())
            }.disposed(by: disposeBag)
        
        return Output(bookList: bookList, successReturnID: succesReturnId)
    }
}
