//
//  ShowTopBookVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

class ShowTopBookVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let books = AladinManager.shared.getBestseller()
    struct Input {
        
    }
    struct Output {
        let bestBookData: BehaviorRelay<[Book]>
    }
    func transform(input: Input) -> Output {
        let bestBookData = BehaviorRelay(value: [Book]())
        self.books.subscribe(with: self) { owner, respons in
            switch respons {
            case .success(let books):
                bestBookData.accept(books)
            case .failure(let err):
                print(err)
            }
        }.disposed(by: disposeBag)
            
        
        return Output(bestBookData: bestBookData)

    }
}
