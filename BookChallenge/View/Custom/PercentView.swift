//
//  PercentView.swift
//  BookChallenge
//
//  Created by 박성민 on 8/29/24.
//

import UIKit
import SnapKit

final class PercentView: BaseView {
    let bar = UIView()
    let chargeBar = UIView()
    let leftText = UILabel()
    let rightText = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setUpHierarchy() {
        self.addSubview(bar)
        self.addSubview(chargeBar)
        self.addSubview(leftText)
        self.addSubview(rightText)
    }
    override func setUpLayout() {
        bar.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.horizontalEdges.equalTo(self)
            make.height.equalTo(10)
        }
        chargeBar.snp.makeConstraints { make in
            make.top.leading.equalTo(bar)
            make.height.equalTo(bar)
            make.width.equalTo(0)
        }
        leftText.snp.makeConstraints { make in
            make.top.equalTo(bar.snp.bottom).offset(3)
            make.leading.equalTo(self)
        }
        rightText.snp.makeConstraints { make in
            make.top.equalTo(bar.snp.bottom).offset(3)
            make.trailing.equalTo(self)
        }
    }
    override func setUpView() {
        bar.backgroundColor = .lightGray
        chargeBar.backgroundColor = .mainColor
        bar.layer.cornerRadius = 5
        chargeBar.layer.cornerRadius = 5
        
        leftText.font = .font10
        leftText.textColor = .font
        leftText.textAlignment = .left
        leftText.numberOfLines = 1
        
        rightText.font = .font10
        rightText.textColor = .font
        rightText.textAlignment = .right
        rightText.numberOfLines = 1
    }
    func setUpDate(total: CGFloat, now: CGFloat, left: String, right: String) {
        print(total, now)
        let ratio = now / total
        print("-----------")
        print(bar.frame.width)
        let newWidth = bar.frame.width * ratio
        chargeBar.snp.updateConstraints { make in
            make.width.equalTo(newWidth)
        }
        leftText.text = left
        rightText.text = right
        layoutSubviews()
    }
}
