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
    
    private let disposeBag = DisposeBag()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setUpDate()
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setUpDate()
    }
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
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
            make.horizontalEdges.equalTo(contentView).inset(10)
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
//        let pagePercentView = PercentView()
//        
//        let datePercentView = PercentView()
        bookTitle.font = .boldFont13
        bookTitle.textColor = .font
        bookTitle.textAlignment = .center
        bookTitle.numberOfLines = 1
        
        
    }
    
    func setUpDate() {
        //DispatchQueue.main.async {
            self.pagePercentView.setUpDate(total: 15.5, now: 5.5, left: "감자", right: "고구마")
            self.datePercentView.setUpDate(total: 20.5, now: 20.0, left: "20.2.2", right: "24.2.2")
        //}
        
    }
}
