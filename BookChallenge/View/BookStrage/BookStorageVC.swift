//
//  BookStorageVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

class BookStorageVC: BaseViewController, FetchImageProtocol {
    let test = CapsuleLabel()
    let testimage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testimage)
        testimage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        fetchLSLPImage(imageView: testimage, imageURL: "uploads/posts/test_1724142935751.jpg")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
}
