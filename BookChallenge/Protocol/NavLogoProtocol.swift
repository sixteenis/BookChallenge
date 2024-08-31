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
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 10
        let logo = UIBarButtonItem(customView: logoImageView)
        
        navigationItem.leftBarButtonItem = logo
    }
}
