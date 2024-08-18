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

class ChallengeRoomVC: BaseViewController {
    let createRoomButton = UIButton(type: .custom)
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUpHierarchy() {
        view.addSubview(createRoomButton)
    }
    override func bindData() {
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
    }
    override func setUpView() {
        createRoomButton.setTitle("방만들기", for: .normal)
        createRoomButton.setImage(.createRoomLogo, for: .normal)
        createRoomButton.setTitleColor(.white, for: .normal)
        createRoomButton.backgroundColor = .darkGray
        createRoomButton.layer.cornerRadius = 25
    }
}
