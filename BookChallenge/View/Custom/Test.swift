//
//  Test.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import SnapKit

class Test: BaseButton {
    let a = UIView()
    override func setUpView() {
        self.addSubview(a)
        a.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        a.backgroundColor = .red
    }
}
