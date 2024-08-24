//
//  TestCollectioCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/24/24.
//

import UIKit
import SnapKit

class TestCollectioCell: BaseCollectioViewCell {
    let test = UILabel()
    
    override func setUpView() {
        contentView.addSubview(test)
        test.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
        test.text = "성공????"
        
    }
}
