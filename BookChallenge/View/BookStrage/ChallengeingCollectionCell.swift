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
    
    let pagePercentView = PercentView()
    
    let datePercentView = PercentView()
    
    let recodeButton = PointButton(title: "기록하기")
    let person = UILabel()
    let date = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override func setUpHierarchy() {
        contentView.addSubview(bookImage)
        contentView.addSubview(bookTitle)
        
        contentView.addSubview(pagePercentView)
        contentView.addSubview(datePercentView)
        
        contentView.addSubview(person)
        contentView.addSubview(date)
        contentView.addSubview(recodeButton)
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(5)
            make.horizontalEdges.equalTo(contentView).inset(25)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView).inset(5)
        }
        pagePercentView.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(20)
        }
        datePercentView.snp.makeConstraints { make in
            make.top.equalTo(pagePercentView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(20)
        }
        recodeButton.snp.makeConstraints { make in
            make.top.equalTo(datePercentView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(contentView).inset(25)
            make.height.equalTo(33)
        }
        
    }
    override func setUpView() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.borderColor = UIColor.boarder.cgColor
        contentView.layer.borderWidth = 1
        bookImage.image = UIImage.noBookImage
        bookTitle.text = "고구마 감자국"
        
        pagePercentView.backgroundColor = .systemGray6
        datePercentView.backgroundColor = .systemGray6
        
        //고정값들
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.borderWidth = 1
        
        bookTitle.font = .boldFont13
        bookTitle.textColor = .font
        bookTitle.textAlignment = .center
        bookTitle.numberOfLines = 1
        
        
    }
    
    func setUpDate(model: BookRoomModel) {
        let pagePer = Double(model.bookNowPage)/Double(model.booktotalPage)
        let pageStr = String(format: "%.1f", pagePer*100)
        fetchLSLPImage(imageView: bookImage, imageURL: model.bookurl)
        self.bookTitle.text = model.bookTitle
        self.pagePercentView.setUpDate(total: model.booktotalPage, now: model.bookNowPage, left: "\(pageStr)%", right: "\(model.bookNowPage)/\(model.booktotalPage)p")
        var now = model.nowDate
        // TODO: 이미 기간이 지난 챌린지에 대해 종료하기 버튼과 같은 식으로 다른 곳으로 이동시켜줘야됨... 나중에~
        if now > model.totalDate {
            now = model.totalDate
        }
        self.datePercentView.setUpDate(total: model.totalDate, now: now, left: model.startDate, right: model.endDate)
        
        
    }
}
