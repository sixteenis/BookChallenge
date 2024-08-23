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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let createRoomButton = UIButton(type: .custom)
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.isNavigationBarHidden = true

        self.navigationItem.title = "챌린지 방"
    }
    override func setUpHierarchy() {
        view.addSubview(searchView)
        view.addSubview(searchButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
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
        createRoomButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
            make.width.equalTo(90)
        }
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
    }
    override func setUpView() {
        createRoomButton.setTitle("방만들기", for: .normal)
        createRoomButton.setImage(.createRoomLogo, for: .normal)
        createRoomButton.setTitleColor(.white, for: .normal)
        createRoomButton.backgroundColor = .darkGray
        createRoomButton.layer.cornerRadius = 25
    }
}
