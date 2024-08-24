//
//  ChallengeRoomVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class ChallengeRoomVC: BaseViewController {
    private let searchView = SearchBarView()
    private let searchButton = BaseButton()
    private let line = UIView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.sameTableViewLayout())
    
    private let createRoomView = CapsuleLabel()
    private let createRoomButton = UIButton()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func setUpHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(searchView)
        view.addSubview(searchButton)
        view.addSubview(line)
        view.addSubview(createRoomView)
        view.addSubview(createRoomButton)
    }
    override func bindData() {
        searchButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.pushViewController(view: BookSearchVC())
            }.disposed(by: disposeBag)
        createRoomButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = RoomCreateVC()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                owner.present(nav, animated: true)
            }.disposed(by: disposeBag)
    }
    override func setUpLayout() {
        createRoomView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        createRoomButton.snp.makeConstraints { make in
            make.edges.equalTo(createRoomView)
        }
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(36)
        }
        searchButton.snp.makeConstraints { make in
            make.edges.equalTo(searchView)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        self.navigationItem.title = "챌린지 방"
        createRoomView.setUpData(backColor: .lightGray, title: "방 만들기", image: UIImage.createRoomLogo, font: .font16)
        
        
        line.backgroundColor = .lightGray
        
        collectionView.register(ChallengeCollectionCell.self, forCellWithReuseIdentifier: ChallengeCollectionCell.id)
    }
}
