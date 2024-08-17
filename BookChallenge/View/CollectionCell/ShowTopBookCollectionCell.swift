//
//  ShowBoolCollectionCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

class ShowTopBookCollectionCell: BaseCollectioViewCell {
    
    let bookImage = UIImageView()
    let bookmark = UIImageView()
    private var disposeBag = DisposeBag()
    override func setUpHierarchy() {
        self.addSubview(bookImage)
        self.addSubview(bookmark)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bookmark.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(35)
        }
    }
    override func setUpView() {
        bookmark.image = .bookmark
        bookImage.image = .logo
    }
    func updateUI(data: BookDTO, index: Int) {
        fetchImage(imageView: self.bookImage, imageURL: data.cover)
        switch index {
        case 0:
            bookmark.tintColor = .systemYellow
            bookmark.isHidden = false
        case 1:
            bookmark.tintColor = .systemCyan
            bookmark.isHidden = false
        case 2:
            bookmark.tintColor = .systemGray4
            bookmark.isHidden = false
        default:
            bookmark.isHidden = true
        }
        
    }
}


