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
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: sameTableViewLayout())
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
        collectionView.register(ChallengeingCollectionCell.self, forCellWithReuseIdentifier: ChallengeingCollectionCell.id)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        Observable.just([1,2,3,31])
            .bind(to: collectionView.rx.items(cellIdentifier: ChallengeingCollectionCell.id, cellType: ChallengeingCollectionCell.self)) { (row, element, cell) in
                cell.setUpDate()
                cell.recodeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.simVC.setUpView(text: "고구마입니다.")
                        owner.present(owner.bottomSheet, animated: false)
                    }.disposed(by: self.disposeBag)
                
            }.disposed(by: disposeBag)
        
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

extension ChallengeingVC {
    func sameTableViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2 - 5
        let height = UIScreen.main.bounds.height / 2.5
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 0)
        return layout
    }
}
