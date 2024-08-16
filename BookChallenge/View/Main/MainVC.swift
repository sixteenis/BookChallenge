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
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let showTopBookHeader = UILabel()
    lazy var showTopBookCollection = UICollectionView(frame: .zero, collectionViewLayout: showTopBookLayout())
    
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
        Observable.just([1,2,3,4,5,5])
            .bind(to: showTopBookCollection.rx.items(cellIdentifier: ShowTopBookCollectionCell.id, cellType: ShowTopBookCollectionCell.self)) { (row, element, cell) in

                
            }.disposed(by: disposeBag)
        
    }
    override func setUpHierarchy() {
        view.addSubview(searchView)
        view.addSubview(searchButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setUpContentViewHierarchy()
        
    }
    private func setUpContentViewHierarchy() {
        contentView.addSubview(showTopBookHeader)
        contentView.addSubview(showTopBookCollection)
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
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.top.equalTo(searchView.snp.bottom)
            make.bottom.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
        }
        setUpContentViewLayout()
    }
    private func setUpContentViewLayout() {
        showTopBookHeader.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(10)
        }
        showTopBookCollection.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(showTopBookHeader.snp.bottom).offset(10)
            make.height.equalTo(view.frame.height / 3)
            make.bottom.equalToSuperview()
        }
    }
    override func setUpView() {
        showTopBookHeader.text = "감자국"
        showTopBookCollection.register(ShowTopBookCollectionCell.self, forCellWithReuseIdentifier: ShowTopBookCollectionCell.id)
        showTopBookCollection.backgroundColor = .white
        showTopBookCollection.showsHorizontalScrollIndicator = false

        
    }
    
}
private extension MainVC {
    func showTopBookLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width// - 50 // 20 + 30
        let height = UIScreen.main.bounds.height / 3
        layout.itemSize = CGSize(width: width/1.5, height: height) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        //layout.minimumLineSpacing = 10
        //layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
}
