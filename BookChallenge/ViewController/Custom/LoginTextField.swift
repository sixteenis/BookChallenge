//
//  LoginTextField.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

import SnapKit

final class LoginTextField: BaseView {
    private let logo = UIImageView()
    private let textField = UITextField()
    private let line = UIView()
    
    init(type: LoginTextType) {
        super.init(frame: .zero)
        setUpData(type: type)
    }
    override func setUpHierarchy() {
        self.addSubview(logo)
        self.addSubview(textField)
        self.addSubview(line)
    }
    override func setUpLayout() {
        logo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(25)
            make.leading.equalTo(self)
        }
        textField.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(logo.snp.trailing).offset(10)
            make.bottom.equalTo(line.snp.top).offset(2)
        }
        line.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    override func setUpView() {
        line.backgroundColor = .gray
        logo.tintColor = .gray
    }
    private func setUpData(type: LoginTextType) {
        logo.image = UIImage(systemName: type.logo)
        textField.placeholder = type.placeholder
        textField.isSecureTextEntry = type.secure
    }
    
    func getText() -> String {
        guard let text = textField.text else {return ""}
        return text
    }
}
