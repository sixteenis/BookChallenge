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
    
    override func setUpHierarchy() {
        contentView.addSubview(bookImage)
        contentView.addSubview(limitPerson)
        contentView.addSubview(deadline)
        contentView.addSubview(title)
        contentView.addSubview(content)
        contentView.addSubview(nick)
        //남은 일자, 남은 자리
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        limitPerson.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
        }
        deadline.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(limitPerson.snp.trailing).offset(20)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(limitPerson.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(bookImage.snp.leading).offset(-20)
        }
        content.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(bookImage.snp.leading).offset(-20)
        }
        nick.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(10)
            make.trailing.equalTo(bookImage.snp.leading).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
    }
    override func setUpView() {
        bookImage.contentMode = .scaleToFill
        bookImage.backgroundColor = .red
        title.textColor = .font
        title.textAlignment = .left
        title.numberOfLines = 1
        title.font = .boldFont16
        
        content.textColor = .font
        content.textAlignment = .left
        content.numberOfLines = 2
        content.font = .font14
        
        nick.textColor = .clightGray
        nick.textAlignment = .left
        nick.numberOfLines = 1
        nick.font = .font13
    }
    func setUpData(data: ChallengePostModel) {
        fetchLSLPImage(imageView: bookImage, imageURL: data.bookUrl)
        self.limitPerson.setUpData(backColor: .grayBackground, title: data.limitPerson, image: .limitPerson)
        self.deadline.setUpData(backColor: .grayBackground, title: data.deadLine, image: .deadLine)
        self.title.text = data.title
        self.content.text = data.content
        self.nick.text = data.nick
        
        
    }
}

