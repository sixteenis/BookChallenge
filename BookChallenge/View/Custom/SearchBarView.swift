//
//  SearchBarView.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import SnapKit
final class SearchBarView: BaseView {
    private let backView = UIView()
    private let searchImage = UIImageView()
    private let searchlable = UILabel()
    
    override func setUpHierarchy() {
        self.addSubview(backView)
        self.addSubview(searchImage)
        self.addSubview(searchlable)
        
    }
    override func setUpLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        searchImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(20)
        }
        searchlable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(searchImage.snp.trailing).offset(10)
        }
    }
    override func setUpView() {
        backView.backgroundColor = .systemGray5
        backView.layer.cornerRadius = 15
        searchImage.image = .search
        searchImage.tintColor = .gray
        searchlable.text = "책 검색하기"
        searchlable.textColor = .gray
    }
}
