//
//  RoomCreateVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/19/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit
import Kingfisher

class RoomCreateVC: BaseViewController, FetchImageProtocol {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bookImage = UIImageView()
    private let justPlusBookView = JustPlustView()
    private let bookSearchButton = UIButton()
    private let bookTitle = UILabel()
    private let bookDescription = UILabel()
    
    private let roomTitle = UITextField()
    
    private let disposeBag = DisposeBag()
    private let vm = RoomCreateVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "챌린지 방 만들기"
        
    }
    override func bindData() {
        let getbookId = PublishSubject<String>()
        let input = RoomCreateVM.Input(getbookId: getbookId)
        let output = vm.transform(input: input)
        output.bookInfor
            .bind(with: self) { owner, book in
                owner.setUpBookData(book: book)
            }.disposed(by: disposeBag)
        bookSearchButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = BookSearchVC()
                vc.vm.compltionBookId = { id in
                    getbookId.onNext(id)
                }
                owner.pushViewController(view: vc)
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(justPlusBookView)
        contentView.addSubview(bookImage)
        contentView.addSubview(bookSearchButton)
        contentView.addSubview(bookTitle)
        contentView.addSubview(bookDescription)
        contentView.addSubview(roomTitle)
        
        
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
        bookImage.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(200)
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).inset(10)
        }
        justPlusBookView.snp.makeConstraints { make in
            make.edges.equalTo(bookImage)
        }
        bookSearchButton.snp.makeConstraints { make in
            make.edges.equalTo(bookImage)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        bookDescription.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        roomTitle.snp.makeConstraints { make in
            make.top.equalTo(bookDescription.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).offset(15)
            
            make.bottom.equalTo(contentView) //맨 밑에 이거 넣주삼
        }
    }
    override func setUpView() {
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
    
                
        let item = UIBarButtonItem(image: UIImage(systemName: "xmark"),style: .plain,  target: self, action: #selector(xbuttonTap))
        let saveItem = UIBarButtonItem(title: "게시하기",style: .plain,  target: self, action: #selector(saveButtonTap))
        navigationItem.leftBarButtonItem = item
        navigationItem.rightBarButtonItem = saveItem
        
        bookImage.layer.borderWidth = 1
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        
        bookTitle.textColor = .font
        bookTitle.numberOfLines = 1
        bookTitle.textAlignment = .center
        
        bookDescription.textColor = .font
        bookDescription.numberOfLines = 0
        bookDescription.textAlignment = .left
        
        roomTitle.placeholder = "제목을 입력해주세요."
        
    }
    
}
// MARK: - 네비게이션 부분
private extension RoomCreateVC {
    @objc func xbuttonTap() {
        dismiss(animated: true)
    }
    @objc func saveButtonTap() {
        print("저장")
    }
}
// MARK: - 책 관련 뷰 세팅 부분
private extension RoomCreateVC {
    func setUpBookData(book: BookModel) {
        fetchImage(imageView: bookImage, imageURL: book.postURL)
        bookTitle.text = book.title
        bookDescription.text = book.description
    }
    
}
