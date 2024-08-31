//
//  CapsuleLabel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/24/24.
//

import UIKit
import SnapKit

final class CapsuleLabel: BaseView {
    private let customImage = UIImageView()
    private let customTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
            
        }
    override func setUpHierarchy() {
        self.addSubview(customTitle)
        self.addSubview(customImage)
    
    }
    override func setUpLayout() {
        customTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(customImage.snp.trailing).offset(5)
            
        }
        customImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(5)
            make.size.equalTo(20)
        }
        self.snp.makeConstraints { make in
            make.trailing.equalTo(customTitle).offset(10)
            make.height.equalTo(26)
        }
    }
    override func setUpView() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black.cgColor
        //self.backgroundColor = .red
        //self.customTitle.text = title
        self.customTitle.font = .boldFont14
    }
    
    func setUpData(backColor: UIColor = .systemGray5, title: String, image: UIImage?, font: UIFont = .font12) {
        self.backgroundColor = backColor
        self.customTitle.text = title
        self.customTitle.font = font
        //image?.withTintColor(.mainColor)
        let ri = image?.withTintColor(.mainColor, renderingMode: .alwaysOriginal)
        self.customImage.image = ri
        
        
    }
}
