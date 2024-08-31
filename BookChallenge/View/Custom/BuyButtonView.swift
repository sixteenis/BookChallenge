//
//  BuyButtonView.swift
//  BookChallenge
//
//  Created by 박성민 on 9/1/24.
//

import UIKit
import SnapKit


final class BuyButtonView: BaseView {
    let button = UIButton()
    private let image = UIImageView()
    private let label = UILabel()
    
    override func setUpHierarchy() {
        self.addSubview(image)
        self.addSubview(label)
        self.addSubview(button)
    }
    override func setUpLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        image.snp.makeConstraints { make in
            make.top.equalTo(self).inset(5)
            make.size.equalTo(25)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.centerX.equalTo(image.snp.centerX)
        }
    }
    override func setUpView() {
        image.image = UIImage(systemName: "cart")
        image.tintColor = .darkGray
        
        label.textColor = .darkGray
        label.text = "책구매"
        label.font = .font12
    }
    
}
