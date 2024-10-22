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
    private let getoutButton = UIBarButtonItem(image: UIImage(systemName: "door.left.hand.open"), style: .plain, target: nil, action: nil)
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: sameUserRecodeTableViewLayout())
    private let removeButtonTap = PublishSubject<Void>()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [getoutButton] //, profile
    }
    override func bindData() {
        let input = DetailChallengeingVM.Input(viewWillAppear: Observable.just(()), removeTap: self.removeButtonTap)
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
        output.successRemove
            .bind(with: self) { owner, result in
                if result {
                    owner.popViewController()
                } else {
                    owner.simpleToast(text: "재시도 바람")
                }
            }.disposed(by: disposeBag)
        getoutButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.choiceAlert(title: "챌린지 방을 나가시겠습니까?") {
                    owner.removeButtonTap.onNext(())
                }
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
            make.top.equalTo(bookImage).inset(10)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        datePer.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(15)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
    override func setUpView() {
        bookImage.layer.cornerRadius = 10
        bookImage.layer.borderWidth = 1
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.masksToBounds = true
        
        bookTitle.font = .heavy20
        bookTitle.textColor = .font
        bookTitle.textAlignment = .left
        bookTitle.numberOfLines = 1
        collectionView.register(UseRecordCell.self, forCellWithReuseIdentifier: UseRecordCell.id)
    }
    
}

private extension DetailChallengeingVC {
    func setUpData(_ data: DetailRoomModel) {
        fetchLSLPImage(imageView: bookImage, imageURL: data.bookurl)
        bookTitle.text = data.bookTitle
        datePer.setUpDate(total: data.totalDate, now: data.nowDate, left: data.startDate, right: data.endDate, font: .font14)
    }
    func sameUserRecodeTableViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 7
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
