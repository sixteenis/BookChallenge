//
//  LoginVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let loginTap: ControlEvent<Void>
        let joinTap: ControlEvent<Void>
    }
    struct Output {
        let tryLogin: PublishRelay<Result<Bool,LoginError>>
        let joinTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let email = BehaviorRelay(value: "")
        let password = BehaviorRelay(value: "")
        let result = PublishRelay<Result<Bool,LoginError>>()
        
        input.emailText
            .bind(to: email)
            .disposed(by: disposeBag)
        input.passwordText
            .bind(to: password)
            .disposed(by: disposeBag)
        input.loginTap
            .bind(with: self) { owner, _ in
                if owner.checkText(email: email.value, password: password.value) { //참이면 필터링 성공 네트워킹 해주기
                    result.accept(.success(true))
                } else { //만족안함 다시 세팅하슈
                    result.accept(.failure(.filter))
                }
            }.disposed(by: disposeBag)
        
        return Output(tryLogin: result, joinTap: input.joinTap)
    }
}
private extension LoginVM {
    func checkText(email: String, password: String) -> Bool {
        if !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0 {
            return true
        }else {
            return false
        }
    }
}
