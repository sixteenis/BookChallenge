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

private class DetailBookVC: BaseViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let booktitle = UILabel()
    private let bookImage = UIImageView()
    private let line = UIView()
    
    private let descriptionheader = UILabel()
    private let descriptionTitle = UILabel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    override func setUpLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
        }
    }
    override func setUpView() {
        self.navigationItem.title = "책 정보"
    }
}
