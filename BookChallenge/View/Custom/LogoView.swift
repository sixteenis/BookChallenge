//
//  LogoView.swift
//  BookChallenge
//
//  Created by 박성민 on 8/31/24.
//

import UIKit
import SnapKit

final class LogoView: BaseView {
    private let logo = UIImageView()
    
    override func setUpView() {
        self.addSubview(logo)
        logo.image = .BookChallengeLogo
        logo.contentMode = .scaleToFill
        
        logo.snp.makeConstraints { make in
            make.size.equalTo(self)
        }
        
    }
}
