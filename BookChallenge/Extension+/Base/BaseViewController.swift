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
    
    private lazy var loadingView = UIView()
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
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    func bindData() {}
    func bindNetworkData() {}
    func setUpNav() {
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
extension BaseViewController {
    func simpleToast(text: String) {
        self.view.makeToast(text)
    }
}
// MARK: - 로딩
extension BaseViewController {
    func showLoadingIndicator() {
        self.setUpIndicator()
        self.activityIndicator.startAnimating()
        self.activityIndicator.isUserInteractionEnabled = false
    }
    func hideLoadingIndicator() {
        
        self.activityIndicator.stopAnimating()
        self.loadingView.removeFromSuperview()
        self.activityIndicator.isUserInteractionEnabled = true
        
    }
    func setUpIndicator() {
        view.addSubview(loadingView)
        loadingView.backgroundColor = .darkGray
        loadingView.layer.masksToBounds = true
        loadingView.layer.cornerRadius = 15
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(70)
        }
        loadingView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
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


