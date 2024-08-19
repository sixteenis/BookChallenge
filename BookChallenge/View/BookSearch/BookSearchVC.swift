//
//  BookSearchVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit
// TODO: 페이지네이션 해주기
// TODO: 검색 클릭 시 텍스트 지우고 서치뷰 원상복구 해주는 로직 짜기
class BookSearchVC: BaseViewController {
    lazy var bookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: sameTableViewLayout())
    //let searchController = UISearchController(searchResultsController: nil)
    let bookSearchBar = UISearchBar()
    
    private let disposeBag = DisposeBag()
    let vm = BookSearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func bindData() {
        
        let searchTap = bookSearchBar.rx.searchButtonClicked
        let searchText = bookSearchBar.rx.text.orEmpty
        let selectBook = PublishSubject<String>()
        let input = BookSearchVM.Input(searchButtonTap: searchTap, searchText: searchText, tapBook: selectBook)
        let output = vm.transform(input: input)
        
        output.bookList
            .bind(to: bookCollectionView.rx.items(cellIdentifier: BookListCollectionCell.id, cellType: BookListCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(data: element)
            }.disposed(by: disposeBag)
        bookCollectionView.rx.modelSelected(BookDTO.self)
            .bind(with: self) { owner, item in
                selectBook.onNext(item.isbn13)
            }.disposed(by: disposeBag)
        output.successReturnID
            .bind(with: self) { owner, _ in
                owner.popViewController()
            }.disposed(by: disposeBag)
        
    }
    override func setUpHierarchy() {
        view.addSubview(bookSearchBar)
        view.addSubview(bookCollectionView)
    }
    override func setUpLayout() {
        bookSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        bookCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bookSearchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    override func setUpView() {
        bookSearchBar.placeholder = "책 제목을 입력해주세요."
        self.navigationItem.title = "책 검색"
        bookCollectionView.register(BookListCollectionCell.self, forCellWithReuseIdentifier: BookListCollectionCell.id)
        
    }
}
extension BookSearchVC {
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
