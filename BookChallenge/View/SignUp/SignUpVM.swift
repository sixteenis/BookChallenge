//
//  SignUpVM.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let xMarkTap: ControlEvent<Void>
        let JoinTap: ControlEvent<Void>
        let emailText: ControlProperty<String>
        let nickNameText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let repasswordText: ControlProperty<String>
    }
    struct Output{
        let xMarkTap: ControlEvent<Void>
        let tryJoin: PublishRelay<Result<Bool,Error>>
    }
    func transform(input: Input) -> Output {
        let email = BehaviorRelay(value: "")
        let nickName = BehaviorRelay(value: "")
        let password = BehaviorRelay(value: "")
        let repassword = BehaviorRelay(value: "")
        let result = PublishRelay<Result<Bool,Error>>()
        
        input.emailText
            .bind(to: email).disposed(by: disposeBag)
        input.nickNameText
            .bind(to: nickName).disposed(by: disposeBag)
        input.passwordText
            .bind(to: password).disposed(by: disposeBag)
        input.repasswordText
            .bind(to: repassword).disposed(by: disposeBag)
        
        input.JoinTap
            .bind(with: self) { owner, _ in
                if let noerr = owner.allCheck(email: email.value, nickname: nickName.value, password: password.value, repassword: repassword.value) {
                    result.accept(.failure(noerr))
                } else {
                    result.accept(.success(true))
                }
            }.disposed(by: disposeBag)
        
        
            
        
        return Output(xMarkTap: input.xMarkTap, tryJoin: result)
    }
    
}

private extension SignUpVM {
    func allCheck(email: String, nickname: String, password: String, repassword: String) -> NetworkError? {
        if !checkEmail(email: email) {
            return .badRequest
        }
        if !checkNickname(nick: nickname) {
            return .badRequest
        }
        if !checkPassword(password: password, repassword: repassword) {
            return .badRequest
        }
        return nil
    }
    func checkEmail(email: String) -> Bool {
        if !email.isEmpty && email.contains("@") && email.contains(".") {
            return true
        }
        return false
        
    }
    func checkNickname(nick: String) -> Bool {
        if !nick.isEmpty {
            return true
        }
        return false
    }
    func checkPassword(password: String, repassword: String) -> Bool {
        if password == repassword && password.count > 0 {
            return true
        }
        return false
    }
}
