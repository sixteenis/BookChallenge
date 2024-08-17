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
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    struct Output {
        let bookList: Observable<[BookDTO]>
        
    }
    func transform(input: Input) -> Output {
        let bookList = PublishSubject<[BookDTO]>()
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
        
        
        return Output(bookList: bookList)
    }
}
