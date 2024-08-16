//
//  BookSearchVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

class BookSearchVC: BaseViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func setUpHierarchy() {
        
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
