//
//  CompletionChallengVC.swift
//  BookChallenge
//
//  Created by 박성민 on 10/22/24.
//

import UIKit
import RxSwift
import SnapKit



final class CompletionChallengVC: BaseViewController {
    private let disposeBag = DisposeBag()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: sameTableViewLayout())
    private let completionData: [CompletionModel] = [
        CompletionModel(imageURL: "uploads/posts/BookChallenge_1729496788343.jpg", title: "소년이 온다", isCompletion: .success, totalPage: 216, resultPage: 216),
        CompletionModel(imageURL: "uploads/posts/BookChallenge_1729494374339.jpg", title: "한강", isCompletion: .success, totalPage: 92, resultPage: 92),
        CompletionModel(imageURL: "uploads/posts/BookChallenge_1729494059592.jpg", title: "디 에센셜 한강", isCompletion: .fail, totalPage: 364, resultPage: 241),
        CompletionModel(imageURL: "uploads/posts/BookChallenge_1729263450874.jpg", title: "스즈짱의 뇌", isCompletion: .success, totalPage: 36, resultPage: 36),
        CompletionModel(imageURL: "uploads/posts/BookChallenge_1724935676757.jpg", title: "iOS 앱 개발을 위한 Swift 3", isCompletion: .fail, totalPage: 1192, resultPage: 670),
        CompletionModel(imageURL: "uploads/posts/BookChallenge_1724935417811.jpg", title: "고구마구마", isCompletion: .success, totalPage: 57, resultPage: 57),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func bindData() {
        Observable.just(completionData)
            .bind(to: collectionView.rx.items(cellIdentifier: CompletionChallengCell.id, cellType: CompletionChallengCell.self)) { (row, element, cell) in
                cell.setUpData(data: element)
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(collectionView)
    }
    override func setUpLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        collectionView.register(CompletionChallengCell.self, forCellWithReuseIdentifier: CompletionChallengCell.id)
    }
    private func sameTableViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 5
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        return layout
    }
}
