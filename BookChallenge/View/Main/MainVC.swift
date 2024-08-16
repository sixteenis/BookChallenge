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
    let searchView = SearchBarView()
    let searchButton = BaseButton()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserManager.shared.token)
        print(UserManager.shared.refreshToken)
        print(UserManager.shared.email)
        print(UserManager.shared.password)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func bindData() {
        searchButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.pushViewController(view: BookSearchVC())
            }.disposed(by: disposeBag)
        
    }
    override func setUpHierarchy() {
        view.addSubview(searchView)
        view.addSubview(searchButton)
        
    }
    override func setUpLayout() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(36)
        }
        searchButton.snp.makeConstraints { make in
            make.edges.equalTo(searchView)
        }
    }
    override func setUpView() {

        
    }
    
}
