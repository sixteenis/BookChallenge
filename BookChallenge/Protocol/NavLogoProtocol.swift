//
//  NavLogoProtocol.swift
//  BookChallenge
//
//  Created by 박성민 on 8/31/24.
//

import UIKit

protocol NavLogoProtocol where Self: UIViewController {
    func setNav()
}

extension NavLogoProtocol {
    func setNav() {
        let logoImageView = LogoView()
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        let logo = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = logo
    }
}
