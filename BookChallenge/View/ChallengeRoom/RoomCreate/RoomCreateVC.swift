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
    private let bookDescriptionHeader = UILabel()
    private let bookDescription = UILabel()
    
    private let bookDivisionContentLine = UIView()
    private let roomTitleView = UIView()
    private let roomTitle = UITextField()
    private let roomContentView = UIView()
    private let roomContent = UITextView()
    
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
        
        roomContent.rx.didBeginEditing
            .bind(with: self) { owner, _ in
                if owner.roomContent.textColor == .placeholder {
                    owner.roomContent.text = ""
                    owner.roomContent.textColor = .font
                }
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        //책 부분
        contentView.addSubview(justPlusBookView)
        contentView.addSubview(bookImage)
        contentView.addSubview(bookSearchButton)
        contentView.addSubview(bookTitle)
        contentView.addSubview(bookDescriptionHeader)
        contentView.addSubview(bookDescription)
        //방 세팅 부분
        contentView.addSubview(bookDivisionContentLine)
        contentView.addSubview(roomTitleView)
        contentView.addSubview(roomTitle)
        contentView.addSubview(roomContentView)
        contentView.addSubview(roomContent)
        
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
        setUpBookLayout()
        setUpContentLayout()
        
    }
    override func setUpView() {
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
    
                
        let item = UIBarButtonItem(image: UIImage(systemName: "xmark"),style: .plain,  target: self, action: #selector(xbuttonTap))
        let saveItem = UIBarButtonItem(title: "게시하기",style: .plain,  target: self, action: #selector(saveButtonTap))
        navigationItem.leftBarButtonItem = item
        navigationItem.rightBarButtonItem = saveItem
        
        setUpBookView()
        setUpContentView()
        roomTitle.placeholder = "제목을 입력해주세요."
        
    }
    
}
// MARK: - 네비게이션 부분
private extension RoomCreateVC {
    @objc func xbuttonTap() {
        dismiss(animated: true)
    }
    @objc func saveButtonTap() {
        print(self.roomContent.text)
    }
}
// MARK: - 책 관련 뷰 세팅 부분
private extension RoomCreateVC {
    func setUpBookLayout() {
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
            make.top.equalTo(bookImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        bookDescriptionHeader.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        bookDescription.snp.makeConstraints { make in
            make.top.equalTo(bookDescriptionHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
    }
    func setUpBookView() {
        bookImage.layer.borderWidth = 1
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        
        bookTitle.textColor = .font
        bookTitle.font = .boldFont14
        bookTitle.numberOfLines = 1
        bookTitle.textAlignment = .center
        
        bookDescriptionHeader.textColor = .font
        bookDescriptionHeader.font = .boldFont16
        bookDescriptionHeader.numberOfLines = 1
        bookDescriptionHeader.textAlignment = .left
        
        bookDescription.textColor = .font
        bookDescription.numberOfLines = 0
        bookDescription.textAlignment = .left
    }
    func setUpBookData(book: BookModel) {
        fetchImage(imageView: bookImage, imageURL: book.postURL)
        bookTitle.text = book.title
        bookDescriptionHeader.text = book.descriptionHeader
        bookDescription.text = book.description
    }
    
}
// MARK: - 컨텐츠 뷰 세팅 부분
private extension RoomCreateVC {
    func setUpContentLayout() {
        bookDivisionContentLine.snp.makeConstraints { make in
            make.top.equalTo(bookDescription.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(1)
        }
        roomTitleView.snp.makeConstraints { make in
            make.top.equalTo(bookDivisionContentLine.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(44)
        }
        roomTitle.snp.makeConstraints { make in
            make.edges.equalTo(roomTitleView).inset(10)
        }
        
        roomContentView.snp.makeConstraints { make in
            make.top.equalTo(roomTitleView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(150)
            make.bottom.equalTo(contentView) //맨 밑에 이거 넣주삼
        }
        roomContent.snp.makeConstraints { make in
            make.edges.equalTo(roomContentView).inset(10)
        }
    }
    func setUpContentView() {
        bookDivisionContentLine.backgroundColor = .darkBoarder
        
        roomTitleView.layer.borderWidth = 2
        roomTitleView.layer.borderColor = UIColor.systemGray4.cgColor
        roomTitleView.layer.cornerRadius = 5
        roomTitle.font = .font13
        
        roomContentView.layer.borderWidth = 2
        roomContentView.layer.borderColor = UIColor.systemGray4.cgColor
        roomContentView.layer.cornerRadius = 5
        roomContent.text = "내용을 입력해 주세요."
        roomContent.textColor = .placeholder
        roomContent.font = .font13
    }
    func setUpContentData() {
        
    }
}
