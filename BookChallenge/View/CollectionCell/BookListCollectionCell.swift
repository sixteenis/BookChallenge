//
//  BookTableCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import UIKit
import SnapKit
import Kingfisher

final class BookListCollectionCell: BaseCollectioViewCell {
    private let bookImage = UIImageView()
    private let title = UILabel()
    private let subTitle = UILabel()
    private let publisherTitle = UILabel()
    private let date = UILabel()
    
    override func setUpHierarchy() {
        self.addSubview(bookImage)
        self.addSubview(title)
        self.addSubview(subTitle)
        self.addSubview(publisherTitle)
        self.addSubview(date)
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(80)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        subTitle.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(title.snp.bottom).offset(5)
        }
        publisherTitle.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(5)
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        date.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(15)
        }
        
    }
    override func setUpView() {
        title.font = .boldSystemFont(ofSize: 16)
        title.textColor = .font
        title.numberOfLines = 1
        title.textAlignment = .left
        
        subTitle.font = .systemFont(ofSize: 14)
        subTitle.textColor = .clightGray
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .left
        
        publisherTitle.font = .systemFont(ofSize: 14)
        publisherTitle.textColor = .clightGray
        publisherTitle.numberOfLines = 1
        publisherTitle.textAlignment = .left
        
        date.font = .systemFont(ofSize: 12)
        date.textColor = .clightGray
        date.numberOfLines = 1
        date.textAlignment = .right
        
        
    }
    func setUpData(data: BookModel) {
        fetchImage(imageView: bookImage, imageURL: data.bookURL)
        title.text = data.title
        setUpPublisher(publisher: data.publisher)
        setUpSubTitle(author: data.author)
        setUpPubDate(date: data.pubDate)
    }
    
}
private extension BookListCollectionCell {
    func setUpSubTitle(author: String) {
        self.subTitle.text = "작가 : " + author
    }
    func setUpPublisher(publisher: String) {
        self.publisherTitle.text = "출판사 : " + publisher
    }
    func setUpPubDate(date: String) {
        self.date.text = "출판일 " + date
    }
}
