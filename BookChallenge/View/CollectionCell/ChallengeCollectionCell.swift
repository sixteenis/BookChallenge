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
    private let title = UILabel()
    private let content = UILabel()
    private let date = UILabel()
    private let personImage = UIImageView()
    private let personCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    override func setUpHierarchy() {
        self.addSubview(bookImage)
        self.addSubview(title)
        self.addSubview(content)
        self.addSubview(date)
        self.addSubview(personImage)
        self.addSubview(personCount)
        
        //남은 일자, 남은 자리
        
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(content).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.trailing.equalTo(bookImage.snp.leading).offset(10)
        }
        content.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(title.snp.bottom).offset(5)
            make.trailing.equalTo(bookImage.snp.leading).offset(10)
        }
        
    }
    override func setUpView() {
        
    }
}

