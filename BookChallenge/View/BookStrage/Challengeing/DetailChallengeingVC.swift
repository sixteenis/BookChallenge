//
//  DetailChallengeingVC.swift
//  BookChallenge
//
//  Created by 박성민 on 9/2/24.
//

import UIKit
import RxSwift
import SnapKit

final class DetailChallengeingVC: BaseViewController, FetchImageProtocol {
    let vm = DetailChallengeingVM()
    private let disposeBag = DisposeBag()
    private let bookImage = UIImageView()
    private let bookTitle = UILabel()
    private let datePer = PercentView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: sameUserRecodeTableViewLayout())
    let test = Observable.just([1,2,3,4,5,6])
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func bindData() {
        let input = DetailChallengeingVM.Input(viewWillAppear: Observable.just(()))
        let output = vm.transform(input: input)
        output.postInfo
            .map { $0.userData }
            .bind(to: collectionView.rx.items(cellIdentifier: UseRecordCell.id, cellType: UseRecordCell.self)) { (row, element, cell) in
                cell.setData(element)
            }.disposed(by: disposeBag)
        output.postInfo
            .bind(with: self) { owner, data in
                owner.setUpData(data)
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(bookImage)
        view.addSubview(bookTitle)
        view.addSubview(datePer)
        view.addSubview(collectionView)
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(80)
            make.height.equalTo(120)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImage)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        datePer.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(30)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
    override func setUpView() {
        collectionView.register(UseRecordCell.self, forCellWithReuseIdentifier: UseRecordCell.id)
    }
    
}

private extension DetailChallengeingVC {
    func setUpData(_ data: DetailRoomModel) {
        fetchLSLPImage(imageView: bookImage, imageURL: data.bookurl)
        bookTitle.text = data.bookTitle
        datePer.setUpDate(total: data.nowDate, now: data.nowDate, left: data.startDate, right: data.endDate)
    }
    func sameUserRecodeTableViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 4
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
