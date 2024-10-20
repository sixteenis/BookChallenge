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
//    lazy var simVC = SimVC()
//    lazy var bottomSheet = BottomSheetVC(contentViewController: simVC, defaultHeight: 400,cornerRadius: 15, isPannedable: true)
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: sameTableViewLayout())
    private let disposeBag = DisposeBag()
    private let vm = ChallengeingVM()
    var itemSelect: ((BookRoomModel) -> ())?
    private let viewWillAppearRx = PublishRelay<Void>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRx.accept(())
    }
    override func bindData() {
        let startNetworking = PublishSubject<Void>()
        
        let input = ChallengeingVM.Input(bottomSheetNetwork: startNetworking, viewWillAppear: viewWillAppearRx)
        let output = vm.transform(input: input)
        output.challnegeingData
            .bind(to: collectionView.rx.items(cellIdentifier: ChallengeingCollectionCell.id, cellType: ChallengeingCollectionCell.self)) { (row, element, cell) in
                cell.setUpDate(model: element)
                cell.recodeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let vc = SimVC()
                        print(element.bookTitle)
                        vc.setUpView(bookTitle: element.bookTitle, page: element.bookNowPage, totalPage: element.booktotalPage, postId: element.postId)
                        let bottomSheet = BottomSheetVC(contentViewController: vc, defaultHeight: 400,cornerRadius: 15, isPannedable: true)
                        vc.completion = {
                            startNetworking.onNext(())
                        }
                        owner.present(bottomSheet, animated: false)
                        
                    }.disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
//        collectionView.rx.itemSelected
//            .bind(with: self) { owner, i in
//                print(i)
//                print("123123213")
//            }.disposed(by: disposeBag)
        collectionView.rx.modelSelected(BookRoomModel.self)
            .bind(with: self) { owner, data in
                print("???")
                owner.itemSelect?(data)
                
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(collectionView)
        collectionView.register(ChallengeingCollectionCell.self, forCellWithReuseIdentifier: ChallengeingCollectionCell.id)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    override func setUpLayout() {
        
    }
    override func setUpView() {
        
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
