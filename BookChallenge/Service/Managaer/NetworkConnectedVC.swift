//
//  NetworkConnectedVC.swift
//  BookChallenge
//
//  Created by 박성민 on 9/5/24.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

final class NetworkConnectedVC: BaseViewController {
    let networkImage = UIImageView()
    let networkTitle = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(networkImage)
        view.addSubview(networkTitle)
        networkImage.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(100)
        }
        networkTitle.snp.makeConstraints { make in
            make.top.equalTo(networkImage.snp.bottom).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        networkImage.image = UIImage(systemName: "network.slash")
        networkTitle.text = "네트워크 상태를 확인해주세요!"
        networkTitle.font = .boldFont16
        networkTitle.textColor = .font
    }
}
