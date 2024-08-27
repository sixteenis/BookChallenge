//
//  ChallengeingVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/26/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ChallengeingVC: BaseViewController {
    //let button = UIButton()
    lazy var simVC = SimVC()
    lazy var bottomSheet = BottomSheetVC(contentViewController: simVC, defaultHeight: 400,cornerRadius: 15, isPannedable: true)
    let collectionView = UICollectionView()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUpHierarchy() {
    //    view.addSubview(button)
        view.addSubview(collectionView)
        
//        button.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
        collectionView.register(ChallengeCollectionCell.self, forCellWithReuseIdentifier: ChallengeCollectionCell.id)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
//        button.setTitle("버튼", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.simVC.setUpView(text: "고구마입니다.")
//                owner.present(owner.bottomSheet, animated: false)
//                
//            }.disposed(by: disposeBag)
    }
}
