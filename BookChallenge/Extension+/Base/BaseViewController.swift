//
//  BaseViewController.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit
import Toast
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    private lazy var loadingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0,  width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .systemBackground
        return view
    }()
    private lazy var activityIndicator: NVActivityIndicatorView = {
        
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                                                        type: .ballBeat,
                                                        color: .clightGray,
                                                        padding: .zero)
        return activityIndicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        setUpHierarchy()
        setUpView()
        setUpLayout()
        bindData()
        setUpNav()
        bindNetworkData()
        setUpIndicator()
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    func bindData() {}
    func bindNetworkData() {}
    func setUpNav() {
        navigationController?.navigationBar.tintColor = .black
    }
    func setUpIndicator() {
        view.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
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
extension BaseViewController {
    func simpleToast(text: String) {
        self.view.makeToast(text)
    }
}
// MARK: - 로딩
extension BaseViewController {
    func showLoadingIndicator() {
        self.activityIndicator.startAnimating()
    }
    func hideLoadingIndicator() {
        self.activityIndicator.stopAnimating()
        self.loadingView.removeFromSuperview()
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


