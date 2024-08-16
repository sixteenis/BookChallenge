//
//  MainVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class MainVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserManager.shared.token)
        print(UserManager.shared.refreshToken)
        print(UserManager.shared.email)
        print(UserManager.shared.password)
    }
    
}
