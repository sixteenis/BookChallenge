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
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.leading.equalTo(userProfile.snp.trailing).offset(15)
        }
        userContentHeader.snp.makeConstraints { make in
            make.bottom.equalTo(userNick.snp.bottom)
            make.leading.equalTo(userNick.snp.trailing).offset(10)
        }
        userContent.snp.makeConstraints { make in
            make.top.equalTo(userContentHeader.snp.bottom).offset(10)
            make.leading.equalTo(userProfile.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        bookPercent.snp.makeConstraints { make in
            make.top.equalTo(userContent.snp.bottom).offset(15)
            make.leading.equalTo(userProfile.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        
    }
    override func setUpView() {
        userProfile.layer.cornerRadius = 15
        userProfile.layer.masksToBounds = true
        userProfile.layer.borderWidth = 1
        userProfile.layer.borderColor = UIColor.boarder.cgColor
        
        userNick.font = .boldFont16
        
        userContentHeader.font = .font13
        userContentHeader.textColor = .placeholder
        
        userContent.textAlignment = .left
        userContent.numberOfLines = 3
        userContent.font = .font13
    }
    func setData(_ data: UserData) {
        userProfile.image = UIImage(named: data.profileImage)
        userNick.text = data.name
        userContentHeader.text = data.date
        let pagePer = Double(data.nowPage)/Double(data.totalPage)
        let pageStr = String(format: "%.1f", pagePer*100)
        bookPercent.setUpDate(total: data.totalPage, now: data.nowPage, left: "\(pageStr)%", right: "\(data.nowPage) /\(data.totalPage)p")
        userContent.text = data.content
    }
}

//let pagePer = Double(model.bookNowPage)/Double(model.booktotalPage)
//let pageStr = String(format: "%.1f", pagePer*100)
//fetchLSLPImage(imageView: bookImage, imageURL: model.bookurl)
//self.bookTitle.text = model.bookTitle
//self.pagePercentView.setUpDate(total: model.booktotalPage, now: model.bookNowPage, left: "\(pageStr)%", right: "\(model.bookNowPage)/\(model.booktotalPage)p")
