//
//  LoginVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit
import SnapKit
import Then

final class LoginVC: BaseViewController {
    let loginLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .font
        $0.text = String.appName + " 로그인"
        $0.textAlignment = .center
    }
    let appLogo = UIImageView().then {
        $0.image = UIImage.logo
    }
    
    let emailTextFiled = LoginTextField(type: .email)
    let passwordTextFiled = LoginTextField(type: .passwoard)
    let loginButton = PointButton(title: "로그인하기")
    let joinButton = UIButton().then {
        $0.setTitle("회원가입하기", for: .normal)
        $0.setTitleColor(.font, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
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
            //make.centerX.equalToSuperview()
        }
    }
    override func setUpView() {
    }
}
