//
//  BaseViewController.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

class BaseViewController: UIViewController {
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loadingIndicator)
        setUpHierarchy()
        setUpView()
        setUpLayout()
        bindData()
        setUpNavLeft()
        bindNetworkData()
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    func bindData() {}
    func bindNetworkData() {}
    func setUpNavLeft() {
        navigationController?.navigationBar.tintColor = .black
    }
}
// MARK: - 알림
extension BaseViewController {
    func simpleAlert(type: LoggableError) {
        let alert = UIAlertController(
            title: nil,
            message: type.message,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "확인", style: .default)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    func simpleAlert(title: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(
            title: nil,
            message: title,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
// MARK: - 로딩
extension BaseViewController {
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        loadingIndicator.center = view.center
    }
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}
// MARK: - 뷰 전환 부분
extension BaseViewController {
    func pushViewController(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
