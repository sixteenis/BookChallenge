//
//  NavLogoProtocol.swift
//  BookChallenge
//
//  Created by 박성민 on 8/31/24.
//

import UIKit
import SnapKit
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
        
        let image = SelcetProfileImageView()
        image.snp.makeConstraints { make in
            make.size.equalTo(35)
        }
        let profile = UIBarButtonItem(customView: image)
        let alert = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [alert, profile]
    }
}
