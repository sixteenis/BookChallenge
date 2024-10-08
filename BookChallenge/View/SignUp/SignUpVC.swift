//
//  SignUpVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class SignUpVC: BaseViewController {
    private let xButton = UIButton()
    private let signuptitle = UILabel()
    private let email = LoginTextField(type: .email)
    private let nickName = LoginTextField(type: .nickName)
    private let password = LoginTextField(type: .password)
    private let repassword = LoginTextField(type: .repassword)
    private let signUpButton = PointButton(title: "회원가입")
    
    private let disposeBag = DisposeBag()
    private let vm = SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func bindData() {
        let input = SignUpVM.Input(xMarkTap: xButton.rx.tap, JoinTap: signUpButton.rx.tap, emailText: email.getText(), nickNameText: nickName.getText(), passwordText: password.getText(), repasswordText: repassword.getText())
        let output = vm.transform(input: input)
        output.xMarkTap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
//        output.tryJoin
//            .bind(with: self) { owner, result in
//                switch result {
//                case .success(let success):
//                    print(success)
//                case .failure(let failure):
//                    owner.simpleAlert(type: failure.asAFError)
//                }
//            }.disposed(by: disposeBag)
            
    }
    override func setUpHierarchy() {
        view.addSubview(xButton)
        view.addSubview(signuptitle)
        view.addSubview(email)
        view.addSubview(nickName)
        view.addSubview(password)
        view.addSubview(repassword)
        view.addSubview(signUpButton)
    }
    override func setUpLayout() {
        xButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        signuptitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.centerX.equalToSuperview()
        }
        email.snp.makeConstraints { make in
            make.top.equalTo(signuptitle.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        nickName.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        password.snp.makeConstraints { make in
            make.top.equalTo(nickName.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        repassword.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(repassword.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }
    override func setUpView() {
        signuptitle.text = String.appName + " 회원가입"
        signuptitle.font = .boldSystemFont(ofSize: 20)
        signuptitle.textAlignment = .center
        
        xButton.setImage(.xMark, for: .normal)
        xButton.tintColor = .black
    }
}
