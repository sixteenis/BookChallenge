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

class BookStorageVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}
