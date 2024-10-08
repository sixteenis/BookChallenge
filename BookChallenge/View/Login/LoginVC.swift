//
//  LoginVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit


final class LoginVC: BaseViewController, ChangeView {
    private let loginLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .font
        view.text = String.appName + " 로그인"
        view.textAlignment = .center
        return view
    }()
    private let appLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.logo
        return view
    }()
    
    private let emailTextFiled = LoginTextField(type: .email)
    private let passwordTextFiled = LoginTextField(type: .password)
    private let loginButton = PointButton(title: "로그인하기")
    private let joinButton: UIButton =  {
        let view = UIButton()
        view.setTitle("회원가입하기", for: .normal)
        view.setTitleColor(.font, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    private let disposeBag = DisposeBag()
    private let vm = LoginVM()
    
    override func bindData() {
        let input = LoginVM.Input(emailText: emailTextFiled.getText(), passwordText: passwordTextFiled.getText(), loginTap: loginButton.rx.tap, joinTap: joinButton.rx.tap)
        let output = vm.transform(input: input)
        
        output.joinTap
            .bind(with: self) { owner, _ in
                self.present(SignUpVC(), animated: true)
            }.disposed(by: disposeBag)
        
        output.err
            .bind(with: self) { owner, err in
                owner.simpleAlert(type: err)
            }.disposed(by: disposeBag)
        
        output.nextView
            .bind(with: self) { owner, _ in
                //if bool {
                    owner.changeRootView(view: TabBarController())
                //}
            }.disposed(by: disposeBag)
        
    }
    override func setUpHierarchy() {
        view.addSubview(appLogo)
        view.addSubview(loginLabel)
        view.addSubview(emailTextFiled)
        view.addSubview(passwordTextFiled)
        view.addSubview(loginButton)
        view.addSubview(joinButton)
    }
    override func setUpLayout() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.centerX.equalToSuperview()
        }
        appLogo.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(loginLabel.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        emailTextFiled.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(appLogo.snp.bottom).offset(15)
            make.height.equalTo(44)
        }
        passwordTextFiled.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(emailTextFiled.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(passwordTextFiled.snp.bottom).offset(20)
            make.height.equalTo(45)
        }
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
