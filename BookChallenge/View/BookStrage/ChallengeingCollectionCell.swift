//
//  ChallengeingCollectionCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/27/24.
//

import UIKit
import RxSwift
import SnapKit

final class ChallengeingCollectionCell: BaseCollectioViewCell {
    let bookImage = UIImageView()
    let bookTitle = UILabel()
    let bar = UIView()
    let chargeBar = UIView()
    let recodeButton = PointButton(title: "기록하기")
    let person = UILabel()
    let date = UILabel()
    
    override func setUpHierarchy() {
        contentView.addSubview(bookImage)
        contentView.addSubview(bookTitle)
        contentView.addSubview(bar)
        contentView.addSubview(chargeBar)
        contentView.addSubview(person)
        contentView.addSubview(date)
        contentView.addSubview(recodeButton)
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.leading.equalTo(contentView).inset(15)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.leading.equalTo(bookImage.snp.trailing).offset(15)
            make.trailing.equalTo(contentView).inset(15)
        }
        bar.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(10)
            make.leading.equalTo(bookImage.snp.trailing).offset(15)
            make.trailing.equalTo(contentView).inset(15)
            make.height.equalTo(10)
        }
        chargeBar.snp.makeConstraints { make in
            make.centerY.equalTo(bar)
            make.leading.equalTo(bookImage.snp.trailing).offset(15)
            make.width.equalTo(40)
            make.height.equalTo(bar)
        }
        
    }
    override func setUpView() {
        bookImage.image = UIImage.noBookImage
        bookTitle.text = "고구마 감자국 책입니다."
        bar.backgroundColor = .lightGray
        chargeBar.backgroundColor = .mainColor
        
        
        
        //고정값들
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.borderWidth = 1
        
        bookTitle.font = .boldFont15
        bookTitle.textColor = .font
        bookTitle.textAlignment = .center
        bookTitle.numberOfLines = 1
        
        bar.layer.cornerRadius = 15
        chargeBar.layer.cornerRadius = 15
        
        
    }
}
