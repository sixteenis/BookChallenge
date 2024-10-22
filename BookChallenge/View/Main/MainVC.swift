//
//  MainVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

import SnapKit
import NVActivityIndicatorView

final class MainVC: BaseViewController, NavLogoProtocol {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    //private var dataSourc: RxCollectionViewSectionedReloadDataSource<
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: mainLayout())

    private let showTopBookHeader = UILabel()
    
    private lazy var showTopBookCollection = UICollectionView(frame: .zero, collectionViewLayout: showTopBookLayout())
    
    private let userChallengeHeader = UILabel()
    private lazy var userChallengeCollection = UICollectionView(frame: .zero, collectionViewLayout: userChallengeLayout())
    private let userChallnegeDetailsButton = UIButton()
    
    private let challengeRoomHeader = UILabel()
    private lazy var challengeRoomCollection = UICollectionView(frame: .zero, collectionViewLayout: ChallengeRoomLayout())
    private let challengeRoomDetailsButton = UIButton()

    private let disposeBag = DisposeBag()
    private let vm = MainVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func bindData() {
        let viewdidLoadRx = Observable.just(())
        let input = MainVM.Input(viewdidLoadRx: viewdidLoadRx)
        let output = vm.transform(input: input)
        
        output.bestBookData
            .bind(to: showTopBookCollection.rx.items(cellIdentifier: ShowTopBookCollectionCell.id, cellType: ShowTopBookCollectionCell.self)) { (row, element, cell) in
                cell.updateUI(data: element, index: row)
            }.disposed(by: disposeBag)
        
        output.challengeingList
            .bind(to: userChallengeCollection.rx.items(cellIdentifier: UserChallengeCollectionCell.id, cellType: UserChallengeCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(model: element)
            }.disposed(by: disposeBag)
        
        output.challengeRoomList
            .bind(to: challengeRoomCollection.rx.items(cellIdentifier: ChallengeCollectionCell.id, cellType: ChallengeCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(data: element, background: .collectionBackground)
            }.disposed(by: disposeBag)
        
        output.isLoading //리로딩 부분
            .bind(with: self) { owner, value in
                value ? owner.showLoadingIndicator() : owner.hideLoadingIndicator()
            }.disposed(by: disposeBag)
        userChallnegeDetailsButton.rx.tap
            .bind(with: self) { owner, _ in
                self.tabBarController?.selectedIndex = 1
            }.disposed(by: disposeBag)
        challengeRoomDetailsButton.rx.tap
            .bind(with: self) { owner, _ in
                self.tabBarController?.selectedIndex = 2
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setUpContentViewHierarchy()
        
    }
    private func setUpContentViewHierarchy() {
        contentView.addSubview(showTopBookHeader)
        contentView.addSubview(showTopBookCollection)
        contentView.addSubview(userChallengeCollection)
        contentView.addSubview(userChallengeHeader)
        contentView.addSubview(userChallnegeDetailsButton)
        contentView.addSubview(challengeRoomHeader)
        contentView.addSubview(challengeRoomCollection)
        contentView.addSubview(challengeRoomDetailsButton)
    }
    override func setUpLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
        }
        setUpContentViewLayout()
    }
    private func setUpContentViewLayout() {
        showTopBookHeader.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(20)
            make.leading.equalTo(contentView).inset(25)
        }
        showTopBookCollection.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(showTopBookHeader.snp.bottom).offset(15)
            make.height.equalTo(view.frame.height / 2.8)
            
        }
        userChallengeHeader.snp.makeConstraints { make in
            make.top.equalTo(showTopBookCollection.snp.bottom).offset(50)
            make.leading.equalTo(contentView).inset(25)
        }
        userChallengeCollection.snp.makeConstraints { make in
            make.top.equalTo(userChallengeHeader.snp.bottom).inset(10)//.offset(5)
            make.horizontalEdges.equalToSuperview()//.inset(20)
            make.height.equalTo(view.frame.height / 3)
        }
        userChallnegeDetailsButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(15)
            make.bottom.equalTo(userChallengeHeader.snp.bottom).offset(5)//(userChallengeCollection.snp.top).offset(-5)
        }
        challengeRoomHeader.snp.makeConstraints { make in
            make.top.equalTo(userChallengeCollection.snp.bottom).offset(15)
            make.leading.equalTo(contentView).inset(25)
        }
        challengeRoomDetailsButton.snp.makeConstraints { make in
            make.bottom.equalTo(challengeRoomCollection.snp.top).offset(-5)
            make.trailing.equalTo(contentView).inset(25)
        }
        challengeRoomCollection.snp.makeConstraints { make in
            make.top.equalTo(challengeRoomHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(view.frame.height / 5)
            make.bottom.equalTo(contentView).inset(30)
        }
    }
    override func setUpView() {
        navigationItem.title = "홈"
        
        showTopBookHeader.text = "이달의 베스트셀러"
        showTopBookHeader.font = .heavy20
        showTopBookCollection.register(ShowTopBookCollectionCell.self, forCellWithReuseIdentifier: ShowTopBookCollectionCell.id)
        showTopBookCollection.backgroundColor = .collectionBackground
        showTopBookCollection.showsHorizontalScrollIndicator = false
        showTopBookCollection.isPagingEnabled = false
        showTopBookCollection.layer.cornerRadius = 15
        showTopBookCollection.layer.borderWidth = 1
        showTopBookCollection.layer.borderColor = UIColor.boarder.cgColor
        showTopBookCollection.delegate = self
        
        
        userChallengeHeader.text = "참여 중인 챌린지"
        userChallengeHeader.font = .heavy20
        userChallengeCollection.register(UserChallengeCollectionCell.self, forCellWithReuseIdentifier: UserChallengeCollectionCell.id)
        userChallengeCollection.backgroundColor = .collectionBackground
        userChallengeCollection.showsHorizontalScrollIndicator = false
        userChallengeCollection.decelerationRate = .fast
        userChallengeCollection.delegate = self
//        userChallengeCollection.layer.cornerRadius = 15
//        userChallengeCollection.layer.borderWidth = 1
//        userChallengeCollection.layer.borderColor = UIColor.boarder.cgColor
        
        //userChallnegeDetailsButton.setTitle("더보기 >", for: .normal)
        userChallnegeDetailsButton.titleLabel?.font = .font16
        userChallnegeDetailsButton.setTitleColor(.clightGray, for: .normal)
        
        challengeRoomHeader.text = "새로 올라온 챌린지 방"
        challengeRoomHeader.font = .heavy20
        challengeRoomCollection.register(ChallengeCollectionCell.self, forCellWithReuseIdentifier: ChallengeCollectionCell.id)
        challengeRoomCollection.backgroundColor = .collectionBackground
        challengeRoomCollection.showsHorizontalScrollIndicator = false
        challengeRoomCollection.decelerationRate = .fast
        challengeRoomCollection.delegate = self
        challengeRoomCollection.layer.cornerRadius = 15
        challengeRoomCollection.layer.borderWidth = 1
        challengeRoomCollection.layer.borderColor = UIColor.boarder.cgColor
        
        challengeRoomDetailsButton.setTitle("더보기", for: .normal)
        challengeRoomDetailsButton.setImage(.chevron, for: .normal)
        challengeRoomDetailsButton.configuration = .plain()
        challengeRoomDetailsButton.configuration?.imagePlacement = .trailing
        challengeRoomDetailsButton.configuration?.imagePadding = 4
        challengeRoomDetailsButton.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 12)
        challengeRoomDetailsButton.tintColor = .clightGray
        challengeRoomDetailsButton.titleLabel?.font = .font16
        challengeRoomDetailsButton.setTitleColor(.clightGray, for: .normal)
        
    }
    
}

//extension MainVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateNavigationBarTitle(animated: true)
//    }
//    func updateNavigationBarTitle(animated: Bool) {
//        let offset = scrollView.contentOffset.y
//        
//        let setUpLagerTitles = offset <= 20
//        let currentPrefersLargeTitles = self.navigationController?.navigationBar.prefersLargeTitles ?? false
//
//        if setUpLagerTitles != currentPrefersLargeTitles{
//// TODO: 애니메이션을 넣을까말까 고민
//            UIView.animate(withDuration: animated ? 0.1 : 0.0) {
//                self.navigationItem.title = setUpLagerTitles ? "반가워요! \(UserManager.shared.nick)님 :)" : "\(UserManager.shared.nick)님의 홈"
//                self.navigationController?.navigationBar.prefersLargeTitles = setUpLagerTitles
//                self.navigationController?.navigationBar.layoutIfNeeded()
//            }
//        }
//    }
//}
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
    func mainLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
//        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height
        layout.scrollDirection = .vertical
        return layout
    }
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
        let width = UIScreen.main.bounds.width / 2.7 // - 50 // 20 + 30
        let height = width * 1.5 //UIScreen.main.bounds.height / 3.2
        layout.itemSize = CGSize(width: width, height: height) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    func ChallengeRoomLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 30// - 50 // 20 + 30
        let height = UIScreen.main.bounds.height / 5
        layout.itemSize = CGSize(width: width, height: height) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
