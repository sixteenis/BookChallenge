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
    struct User {
        let email: BehaviorRelay<String>
        let password: BehaviorRelay<String>
    }
    struct Input {
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let loginTap: ControlEvent<Void>
        let joinTap: ControlEvent<Void>
    }
    struct Output {
        let err: PublishRelay<LSLPError>
        let nextView: Observable<Void>
        let joinTap: ControlEvent<Void>
        let networkLoading: BehaviorRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let email = BehaviorRelay(value: "")
        let password = BehaviorRelay(value: "")
        
        let result = PublishRelay<(String,String)>() // 필터링 후 결과를 통해 네트워킹 시작
        let loading = BehaviorRelay(value: false) //네트워킹 시작 유무
        let error = PublishRelay<LSLPError>() // 네트워킹 오류 시
        let nextView = PublishSubject<Void>() //성공 시 다음 화면 전환
        
        input.emailText
            .bind(to: email)
            .disposed(by: disposeBag)
        input.passwordText
            .bind(to: password)
            .disposed(by: disposeBag)
        
        input.loginTap //로그인 버튼 누를 시 필터링 해주기
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                if owner.checkText(email: email.value, password: password.value) { //참이면 필터링 성공 네트워킹 해주기
                    result.accept((email.value,password.value))
                } else { //만족안함 다시 세팅하슈
                    error.accept(.filter)
                }
            }.disposed(by: disposeBag)
        
        result //필터링에서 조건 만족 시 통신 시작
            .subscribe(with: self) { owner, respon in
                LSLPUserManager.shared.createLogin(email: respon.0, password: respon.1) { respon in
                    switch respon {
                    case .success(_):
                        nextView.onNext(())
                    case .failure(let err):
                        error.accept(err)
                    }
                }
            }.disposed(by: disposeBag)

        return Output(err: error, nextView: nextView, joinTap: input.joinTap, networkLoading: loading)
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
