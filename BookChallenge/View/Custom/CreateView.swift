//
//  CreateView.swift
//  BookChallenge
//
//  Created by 박성민 on 8/31/24.
//

import UIKit
import SnapKit

final class CreateView: BaseView {
    let createImage = UIImageView()
    override func setUpView() {
        self.addSubview(createImage)
        createImage.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(30)
        }
        let setImage = UIImage.createRoomLogo
        let result = setImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        createImage.image = result
        
    }
}
