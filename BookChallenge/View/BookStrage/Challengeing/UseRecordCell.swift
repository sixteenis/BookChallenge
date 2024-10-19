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
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(60)
            //make.width.equalTo(userProfile.snp.height)
        }
        userNick.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(userProfile.snp.trailing).offset(10)
        }
        userContentHeader.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(userNick.snp.trailing).offset(10)
        }
        userContent.snp.makeConstraints { make in
            make.top.equalTo(userContentHeader.snp.bottom).offset(10)
            make.leading.equalTo(userProfile.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        bookPercent.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(userProfile.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
    }
    override func setUpView() {
        userProfile.image = .profile1
        userNick.text = "테스트용1"
        userContentHeader.text = "2024.07.03"
        userContent.text = "재밌는 책을 읽고 후기를 작성합니디ㅏ~~~ 재밌는 책을 읽고 후기를 작성합니디ㅏ~~~재밌는 책을 읽고 후기를 작성합니디ㅏ~~~재밌는 책을 읽고 후기를 작성합니디ㅏ~~~재밌는 책을 읽고 후기를 작성합니디ㅏ~~~"
        userContent.textAlignment = .left
        userContent.numberOfLines = 0
        bookPercent.setUpDate(total: 300, now: 60, left: "30.0", right: "60/300")
    }
}

