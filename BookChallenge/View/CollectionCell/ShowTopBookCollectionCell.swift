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

final class ShowTopBookCollectionCell: BaseCollectioViewCell {
    
    private let bookImage = UIImageView()
    private let bookmark = UIImageView()
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
            make.top.equalTo(bookImage).offset(-4)
            make.leading.equalTo(bookImage).offset(-9)
            make.size.equalTo(50)
        }
    }
    override func setUpView() {
        bookmark.image = .bookmark
        bookImage.image = .logo
        bookImage.layer.borderWidth = 1
        bookImage.layer.borderColor = UIColor.boarder.cgColor
    }
    func updateUI(data: BookDTO, index: Int) {
        fetchImage(imageView: self.bookImage, imageURL: data.cover)
        switch index {
        case 0:
            bookmark.tintColor = UIColor.init(hex: "D5A11E")
            bookmark.isHidden = false
        case 1:
            bookmark.tintColor = UIColor.init(hex: "A3A3A3")
            bookmark.isHidden = false
        case 2:
            bookmark.tintColor = UIColor.init(hex: "CD7F32")
            bookmark.isHidden = false
        default:
            bookmark.isHidden = true
        }
        
    }
}


