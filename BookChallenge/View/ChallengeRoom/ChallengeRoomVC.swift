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

final class ChallengeRoomVC: BaseViewController, NavLogoProtocol {
    private let searchView = SearchBarView()
    private let searchButton = BaseButton()
    private let line = UIView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.sameTableViewLayout())
    
    private let createRoomView = CreateView()
    private let createRoomButton = UIButton()
    
    private let refreshControl = UIRefreshControl() //당겨서 새로고침
    private let disposeBag = DisposeBag()
    private let vm = ChallengeRoomVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = false
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createRoomView.layer.cornerRadius = createRoomView.frame.width / 2
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
        let getBookSearchId = PublishSubject<String>()
        let refreshRx = refreshControl.rx.controlEvent(.valueChanged)
        
        let input = ChallengeRoomVM.Input(searchBookId: getBookSearchId, pagination: collectionView.rx.prefetchItems, refreshing: refreshRx)
        let output = vm.transform(input: input)
        
        output.challengeRoomLists
            .bind(to: collectionView.rx.items(cellIdentifier: ChallengeCollectionCell.id, cellType: ChallengeCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(data: element)
            }.disposed(by: disposeBag)
        
        output.refreshLoading
            .bind(with: self) { owner, result in
                owner.refreshControl.endRefreshing()
                if result {
                    owner.simpleToast(text: "새로고침 완료!")
                } else {
                    owner.simpleToast(text: "잠시 후 시도해 주세요!")
                }
            }.disposed(by: disposeBag)
        output.scrollTop
            .bind(with: self) { owner, _ in
                owner.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }.disposed(by: disposeBag)
        output.isLoading
            .bind(with: self) { owner, value in
                value ? owner.showLoadingIndicator() : owner.hideLoadingIndicator()
            }.disposed(by: disposeBag)
        searchButton.rx.tap //검색 버튼 클릭 시
            .bind(with: self) { owner, _ in
                let vc = BookSearchVC()
                vc.vm.compltionBook = { book in
                    getBookSearchId.onNext(book.id)
                }
                owner.pushViewController(view: vc)
            }.disposed(by: disposeBag)
        createRoomButton.rx.tap // 방만들기 클릭 시
            .bind(with: self) { owner, _ in
                let vc = RoomCreateVC()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                owner.present(nav, animated: true)
            }.disposed(by: disposeBag)
        
        self.collectionView.rx.modelSelected(ChallengePostModel.self)
            .bind(with: self) { owner, data in
                let vc = ChallengeDetailVC()
                vc.vm.inputData.accept(data.postId)
                owner.pushViewController(view: vc)
            }.disposed(by: disposeBag)
        
    }
    override func setUpLayout() {
        createRoomView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(60)
        }
        createRoomButton.snp.makeConstraints { make in
            make.edges.equalTo(createRoomView)
        }
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
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
            make.top.equalTo(line.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        self.navigationItem.title = "챌린지 방"
        createRoomView.backgroundColor = .mainColor
        createRoomView.layer.masksToBounds = true
        
        
        
        line.backgroundColor = .line
        
        collectionView.backgroundColor = .viewBackground
        collectionView.register(ChallengeCollectionCell.self, forCellWithReuseIdentifier: ChallengeCollectionCell.id)
        collectionView.refreshControl = refreshControl
        
    }
}

extension ChallengeRoomVC {
    func sameTableViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 6
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
