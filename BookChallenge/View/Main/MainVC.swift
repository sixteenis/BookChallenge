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
    private let searchView = SearchBarView()
    private let searchButton = BaseButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let showTopBookHeader = UILabel()
    
    private lazy var showTopBookCollection = UICollectionView(frame: .zero, collectionViewLayout: showTopBookLayout())
    
    private let userChallengeHeader = UILabel()
    private lazy var userChallengeCollection = UICollectionView(frame: .zero, collectionViewLayout: userChallengeLayout())
    
    private let ChallengeRoomHeader = UILabel()
    private lazy var ChallengeRoomCollection = UICollectionView(frame: .zero, collectionViewLayout: ChallengeRoomLayout())
    let challengeRoomDetailsButton = UIButton()
    
    private let disposeBag = DisposeBag()
    private let showTopBookVM = ShowTopBookVM()
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
        let topBookInput = ShowTopBookVM.Input()
        let topBookOutput = showTopBookVM.transform(input: topBookInput)
        
        topBookOutput.bestBookData
            .bind(to: showTopBookCollection.rx.items(cellIdentifier: ShowTopBookCollectionCell.id, cellType: ShowTopBookCollectionCell.self)) { (row, element, cell) in
                cell.updateUI(data: element, index: row)
            }.disposed(by: disposeBag)
        searchButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.pushViewController(view: BookSearchVC())
            }.disposed(by: disposeBag)
        
        Observable.just([1,2,3,31])
            .bind(to: userChallengeCollection.rx.items(cellIdentifier: UserChallengeCollectionCell.id, cellType: UserChallengeCollectionCell.self)) { (row, element, cell) in
                
            }.disposed(by: disposeBag)
        Observable.just([1,2,3,31])
            .bind(to: ChallengeRoomCollection.rx.items(cellIdentifier: ChallengeRoomCollectionCell.id, cellType: ChallengeRoomCollectionCell.self)) { (row, element, cell) in
                
            }.disposed(by: disposeBag)
        challengeRoomDetailsButton.rx.tap
            .bind(with: self) { owner, _ in
                self.tabBarController?.selectedIndex = 2
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
        contentView.addSubview(userChallengeHeader)
        contentView.addSubview(userChallengeCollection)
        contentView.addSubview(ChallengeRoomHeader)
        contentView.addSubview(ChallengeRoomCollection)
        contentView.addSubview(challengeRoomDetailsButton)
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
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(showTopBookHeader.snp.bottom).offset(10)
            make.height.equalTo(view.frame.height / 3)
            
        }
        userChallengeHeader.snp.makeConstraints { make in
            make.top.equalTo(showTopBookCollection.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(10)
        }
        userChallengeCollection.snp.makeConstraints { make in
            make.top.equalTo(userChallengeHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height / 3)
        }
        ChallengeRoomHeader.snp.makeConstraints { make in
            make.top.equalTo(userChallengeCollection.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(10)
        }
        challengeRoomDetailsButton.snp.makeConstraints { make in
            make.top.equalTo(userChallengeCollection.snp.bottom).offset(20)
            make.trailing.equalTo(contentView).inset(10)
        }
        ChallengeRoomCollection.snp.makeConstraints { make in
            make.top.equalTo(ChallengeRoomHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height / 3)
            make.bottom.equalTo(contentView).inset(30)
        }
    }
    override func setUpView() {
        showTopBookHeader.text = "베스트셀러"
        showTopBookCollection.register(ShowTopBookCollectionCell.self, forCellWithReuseIdentifier: ShowTopBookCollectionCell.id)
        showTopBookCollection.backgroundColor = .collectionBackgournd
        showTopBookCollection.showsHorizontalScrollIndicator = false
        showTopBookCollection.isPagingEnabled = false
        showTopBookCollection.layer.cornerRadius = 15
        showTopBookCollection.layer.borderWidth = 1
        showTopBookCollection.layer.borderColor = UIColor.collectionBoarder.cgColor
        showTopBookCollection.delegate = self
        
        
        userChallengeHeader.text = "너가 지금 참가중인거"
        userChallengeCollection.register(UserChallengeCollectionCell.self, forCellWithReuseIdentifier: UserChallengeCollectionCell.id)
        userChallengeCollection.backgroundColor = .white
        userChallengeCollection.showsHorizontalScrollIndicator = false
        userChallengeCollection.decelerationRate = .fast
        userChallengeCollection.delegate = self
        
        
        ChallengeRoomHeader.text = "챌린지 방"
        ChallengeRoomCollection.register(ChallengeRoomCollectionCell.self, forCellWithReuseIdentifier: ChallengeRoomCollectionCell.id)
        ChallengeRoomCollection.backgroundColor = .white
        ChallengeRoomCollection.showsHorizontalScrollIndicator = false
        ChallengeRoomCollection.decelerationRate = .fast
        ChallengeRoomCollection.delegate = self
        
        challengeRoomDetailsButton.setTitle("더 보기", for: .normal)
        challengeRoomDetailsButton.setTitleColor(.clightGray, for: .normal)
        
    }
    
}

// MARK: - 셀 포커싱 해주기
extension MainVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                         y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

private extension MainVC {
    func showTopBookLayout() -> UICollectionViewLayout {
        let layout = CarouselLayout()
        let width = UIScreen.main.bounds.width// - 50 // 20 + 30
        let height = UIScreen.main.bounds.height / 3
        layout.itemSize = CGSize(width: width/2, height: height - 10) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    func userChallengeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width// - 50 // 20 + 30
        let height = UIScreen.main.bounds.height / 3
        layout.itemSize = CGSize(width: width, height: height) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    func ChallengeRoomLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width// - 50 // 20 + 30
        let height = UIScreen.main.bounds.height / 3
        layout.itemSize = CGSize(width: width, height: height) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
