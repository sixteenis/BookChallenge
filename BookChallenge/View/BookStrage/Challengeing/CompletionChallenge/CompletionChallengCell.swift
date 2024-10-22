//
//  CompletionChallengCell.swift
//  BookChallenge
//
//  Created by 박성민 on 10/22/24.
//

import UIKit
import SnapKit
import RxSwift

final class CompletionChallengCell: BaseCollectioViewCell {
    private let bookImage = UIImageView()
    private let title = UILabel()
    private let state = UILabel()
    private let page = PercentView()
    
    
    
    private var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override func setUpHierarchy() {
        contentView.addSubview(bookImage)
        contentView.addSubview(title)
        contentView.addSubview(state)
        contentView.addSubview(page)
        //남은 일자, 남은 자리
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(30)
            make.verticalEdges.equalTo(contentView).inset(20)
            make.width.equalTo(100)
        }
        state.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.height.equalTo(28)
            make.width.equalTo(88)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(state.snp.bottom).offset(15)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(15)
        }
        page.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(35)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(30)
        }
        
    }
    override func setUpView() {
        self.backgroundColor = .viewBackground
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        bookImage.contentMode = .scaleToFill
        bookImage.layer.borderWidth = 1
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        
        title.textColor = .font
        title.textAlignment = .left
        title.numberOfLines = 1
        title.font = .boldFont16
        
        state.font = .font12
        state.textColor = .mainColor
        state.textAlignment = .center
        state.layer.cornerRadius = 15
        state.layer.backgroundColor = UIColor.mainColor.withAlphaComponent(0.5).cgColor
        
        
        
        
    }
    func setUpData(data: CompletionModel) {
        //fetchImage(imageView: self.bookImage, imageURL: data.imageURL)
        fetchLSLPImage(imageView: self.bookImage, imageURL: data.imageURL)
        title.text = data.title
        state.text = data.isCompletion.title
        page.setUpDate(total: data.totalPage, now: data.resultPage, left: "", right: "\(data.resultPage)/\(data.totalPage) 페이지")
    }
}

