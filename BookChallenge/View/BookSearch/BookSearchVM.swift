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
    var compltionBookId: ((String) -> ())?
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let tapBook: PublishSubject<String>
    }
    struct Output {
        let bookList: Observable<[BookProtocol]>
        let successReturnID: Observable<Void>
    }
    func transform(input: Input) -> Output {
        let bookList = PublishSubject<[BookProtocol]>()
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
                    bookList.onNext(data.item)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        input.tapBook
            .bind(with: self) { owner, id in
                owner.compltionBookId?(id)
                succesReturnId.onNext(())
            }.disposed(by: disposeBag)
        
        return Output(bookList: bookList, successReturnID: succesReturnId)
    }
}
