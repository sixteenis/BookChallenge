//
//  ShowBoolCollectionCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import SnapKit

class ShowTopBookCollectionCell: BaseCollectioViewCell {
    let bookImage = UIImageView()
    let bookmark = UIImageView()
    
    override func setUpHierarchy() {
        self.addSubview(bookImage)
        self.addSubview(bookmark)
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bookmark.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }
    }
    override func setUpView() {
        bookmark.image = .bookmark
        bookImage.image = .logo
    }
    func updateUI() {
        
    }
}


