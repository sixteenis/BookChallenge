//
//  ChallengeCollectionCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/24/24.
//

import UIKit
import SnapKit


final class ChallengeCollectionCell: BaseCollectioViewCell {
    private let bookImage = UIImageView()
    private let limitPerson = CapsuleLabel()
    private let deadline = CapsuleLabel()
    private let title = UILabel()
    private let content = UILabel()
    private let nick = UILabel()
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    override func setUpHierarchy() {
        self.addSubview(bookImage)
        self.addSubview(limitPerson)
        self.addSubview(deadline)
        self.addSubview(title)
        self.addSubview(content)
        
        //남은 일자, 남은 자리
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(content).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        limitPerson.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
        deadline.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(limitPerson.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(bookImage.snp.leading).offset(10)
        }
        content.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(title.snp.bottom).offset(5)
            make.trailing.equalTo(bookImage.snp.leading).offset(10)
        }
        nick.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(5)
            make.trailing.equalTo(bookImage.snp.leading).offset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
    }
    override func setUpView() {
        title.textColor = .font
        title.textAlignment = .left
        title.numberOfLines = 1
        title.font = .boldFont14
        
        content.textColor = .font
        content.textAlignment = .left
        content.numberOfLines = 2
        content.font = .font13
        
        nick.textColor = .font
        nick.textAlignment = .left
        nick.numberOfLines = 1
        nick.font = .font13
    }
    func setUpData(data: ChallengePostModel) {
        self.title.text = data.title
        self.content.text = data.content
        //self.bookImage
    }
}

