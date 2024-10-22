//
//  UserChallengeCollectionCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import SnapKit

final class UserChallengeCollectionCell: BaseCollectioViewCell {
    private let bookImage = UIImageView()
    private let bookTitle = UILabel()
    private let bookLable = UILabel()
    private var disposeBag = DisposeBag()
    override func setUpHierarchy() {
        contentView.addSubview(bookImage)
        contentView.addSubview(bookTitle)
        contentView.addSubview(bookLable)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(30)
            make.horizontalEdges.equalTo(contentView).inset(10)
            
        }
        bookTitle.snp.makeConstraints { make in
            make.bottom.equalTo(bookImage.snp.bottom).inset(10)
            //make.top.equalTo(bookImage.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        bookLable.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(10)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
    }
    override func setUpView() {
        contentView.backgroundColor = .collectionBackground
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.borderWidth = 1
        
        bookTitle.textColor = .white
        bookTitle.numberOfLines = 1
        bookTitle.textAlignment = .left
        bookTitle.font = .boldFont15
        
        bookLable.font = .font13
        bookLable.numberOfLines = 1
        bookLable.textAlignment = .left
        bookLable.textColor = .clightGray
        
    }
    func setUpData(model: BookRoomModel) {
        self.fetchLSLPImage(imageView: bookImage, imageURL: model.bookurl)
        bookTitle.text = model.bookTitle
        
        let text = " |  \(model.totalDate - model.nowDate)일 남음"
        let percent = Int(Double(model.bookNowPage) / Double(model.booktotalPage) * 100)
        let percentText = "\(percent)%"
        let percentAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldFont14,
            .foregroundColor: UIColor.darkGray
        ]
        let percentString = NSAttributedString(string: percentText, attributes: percentAttributes)
        let checkAttachment = NSTextAttachment()
        checkAttachment.image = UIImage(systemName: "checkmark")
        
        
        checkAttachment.bounds = CGRect(x: -5, y: 0, width: 11, height: 11)
        
        let imageString = NSAttributedString(attachment: checkAttachment)
        let completeText = NSMutableAttributedString()
        completeText.append(imageString)
        completeText.append(percentString)
        completeText.append(NSAttributedString(string: text))
        bookLable.attributedText = completeText
        
        DispatchQueue.main.async {
            self.addGradientToBigPostView()
        }
    }
}
private extension UserChallengeCollectionCell {
    func addGradientToBigPostView() {
        // 그라데이션 추가
        bookImage.layer.sublayers?
                    .filter { $0 is CAGradientLayer }
                    .forEach { $0.removeFromSuperlayer() }
        let gradient = CAGradientLayer()
        gradient.frame = bookImage.bounds
        gradient.colors = [
                    UIColor.clear.cgColor,
                    UIColor.black.withAlphaComponent(0.5).cgColor
                ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.8)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        bookImage.layer.insertSublayer(gradient, at: 0)
    }
}
