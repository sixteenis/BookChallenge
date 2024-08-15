//
//  BaseViewController.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpHierarchy()
        setUpView()
        setUpLayout()
        bindData()
        setUpNavLeft()
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    func bindData() {}
    func setUpNavLeft() {
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
    }
}
extension BaseViewController {
    func simpleAlert(type: Alert) {
        let alert = UIAlertController(
            title: type.title,
            message: type.message,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "확인", style: .default)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

