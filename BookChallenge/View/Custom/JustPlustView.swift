//
//  JustPlustView.swift
//  BookChallenge
//
//  Created by 박성민 on 8/19/24.
//

import UIKit
import SnapKit


final class JustPlustView: BaseView {
    let plusView = UIImageView()
    let plusTitle = UILabel()
    override func setUpHierarchy() {
        self.addSubview(plusView)
        self.addSubview(plusTitle)
    }
    override func setUpLayout() {
        plusView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-10)
            make.size.equalTo(40)
        }
        plusTitle.snp.makeConstraints { make in
            make.top.equalTo(plusView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    override func setUpView() {
        self.layer.borderWidth = 2  
        self.layer.borderColor = UIColor.boarder.cgColor
        self.backgroundColor = .red
        plusView.image = .plusBook
        plusView.tintColor = .black
        plusTitle.text = "책 추가"
        plusTitle.textColor = .font
        plusTitle.font = .systemFont(ofSize: 14)
        plusTitle.textAlignment = .center
    }
}
