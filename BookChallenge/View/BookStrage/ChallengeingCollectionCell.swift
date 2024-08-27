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
    
    let pagebar = UIView()
    let pageChargeBar = UIView()
    let pagePercent = UILabel()
    let percentPage = UILabel()
    
    let datebar = UIView()
    let dateChargeBar = UIView()
    let datePercent = UILabel()
    let percentdate = UILabel()
    
    let recodeButton = PointButton(title: "기록하기")
    let person = UILabel()
    let date = UILabel()
    
    override func setUpHierarchy() {
        contentView.addSubview(bookImage)
        contentView.addSubview(bookTitle)
        contentView.addSubview(pagebar)
        contentView.addSubview(pageChargeBar)
        contentView.addSubview(pagePercent)
        contentView.addSubview(percentPage)
        contentView.addSubview(datebar)
        contentView.addSubview(dateChargeBar)
        contentView.addSubview(datePercent)
        contentView.addSubview(percentdate)
        contentView.addSubview(person)
        contentView.addSubview(date)
        contentView.addSubview(recodeButton)
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(5)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView).inset(5)
        }
        pagebar.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(10)
        }
        pageChargeBar.snp.makeConstraints { make in
            make.centerY.equalTo(pagebar)
            make.leading.equalTo(pagebar)
            make.width.equalTo(40) //변경해야됨
            make.height.equalTo(pagebar)
        }
        pagePercent.snp.makeConstraints { make in
            make.top.equalTo(pagebar.snp.bottom).offset(3)
            make.leading.equalTo(contentView).inset(15)
        }
        percentPage.snp.makeConstraints { make in
            make.top.equalTo(pagebar.snp.bottom).offset(3)
            make.trailing.equalTo(contentView).inset(15)
        }
        datebar.snp.makeConstraints { make in
            make.top.equalTo(pagebar.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(10)
        }
        dateChargeBar.snp.makeConstraints { make in
            make.centerY.equalTo(datebar)
            make.leading.equalTo(datebar)
            make.height.equalTo(datebar)
            make.width.equalTo(40) // 변경해야됨
        }
        datePercent.snp.makeConstraints { make in
            make.top.equalTo(datebar.snp.bottom).offset(3)
            make.leading.equalTo(contentView).inset(15)
        }
        percentdate.snp.makeConstraints { make in
            make.top.equalTo(datebar.snp.bottom).offset(3)
            make.trailing.equalTo(contentView).inset(15)
        }
        recodeButton.snp.makeConstraints { make in
            make.top.equalTo(datebar.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(contentView).inset(25)
            make.height.equalTo(33)
        }
//        let datebar = UIView()
//        let dateChargeBar = UIView()
//        let datePercent = UILabel()
//        let percentdate = UILabel()
        
    }
    override func setUpView() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.borderColor = UIColor.boarder.cgColor
        contentView.layer.borderWidth = 1
        bookImage.image = UIImage.noBookImage
        bookTitle.text = "고구마 감자국"
        percentPage.text = "50/164p"
        pagePercent.text = "36%"
        datePercent.text = "24.06.01"
        percentdate.text = "24.11.11"
        
        //고정값들
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.borderWidth = 1
        
        bookTitle.font = .boldFont15
        bookTitle.textColor = .font
        bookTitle.textAlignment = .center
        bookTitle.numberOfLines = 1
        
        pagebar.backgroundColor = .lightGray
        pageChargeBar.backgroundColor = .mainColor
        pagebar.layer.cornerRadius = 5
        pageChargeBar.layer.cornerRadius = 5
        
        pagePercent.font = .font10
        pagePercent.textColor = .font
        pagePercent.textAlignment = .left
        pagePercent.numberOfLines = 1
        
        percentPage.font = .font10
        percentPage.textColor = .font
        percentPage.textAlignment = .right
        percentPage.numberOfLines = 1
        
        datebar.backgroundColor = .lightGray
        dateChargeBar.backgroundColor = .mainColor
        datebar.layer.cornerRadius = 5
        dateChargeBar.layer.cornerRadius = 5
        
        datePercent.font = .font10
        datePercent.textColor = .font
        datePercent.textAlignment = .left
        datePercent.numberOfLines = 1
        
        percentdate.font = .font10
        percentdate.textColor = .font
        percentdate.textAlignment = .right
        percentdate.numberOfLines = 1
        

        
    }
}
