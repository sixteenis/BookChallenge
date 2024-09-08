//
//  UseRecordCell.swift
//  BookChallenge
//
//  Created by 박성민 on 9/5/24.
//

import UIKit
import SnapKit

final class UseRecordCell: BaseCollectioViewCell {
    private let userProfile = UIImageView()
    private let userNick = UILabel()
    private let bookPercent = PercentView()
    private let userContentHeader = UILabel()
    private let userContent = UILabel()
    
    
    override func setUpHierarchy() {
        contentView.addSubview(userProfile)
        contentView.addSubview(userNick)
        contentView.addSubview(bookPercent)
        contentView.addSubview(userContentHeader)
        contentView.addSubview(userContent)
    }
    override func setUpLayout() {
        userProfile.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(userProfile.snp.height)
        }
        //userNick.
    }
    override func setUpView() {
        
    }
}

