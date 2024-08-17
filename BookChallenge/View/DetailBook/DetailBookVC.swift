//
//  DetailBookVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

class DetailBookVC: BaseViewController {
    let searchController = UISearchController(searchResultsController: nil)
    let tap = BaseButton()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func setUpHierarchy() {
        view.addSubview(tap)
        tap.setTitle("버튼", for: .normal)
        
        tap.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(30)
        }
        
        tap.rx.tap
            .bind(with: self) { owner, _ in
                print("123123")
                owner.navigationController?.popToRootViewController(animated: true)
                owner.tabBarController?.selectedIndex = 2
            }.disposed(by: disposeBag)
    }
    override func setUpLayout() {
        
    }
    override func setUpView() {
        searchController.searchBar.placeholder = "책 제목을 입력해주세요."
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "책 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
}
