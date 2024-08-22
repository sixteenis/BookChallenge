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

// TODO: content 텍스트 예외처리... 해주자!!! 고민해봐!!!
final class RoomCreateVC: BaseViewController, FetchImageProtocol {
    let saveItem = UIBarButtonItem(title: "게시하기")
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bookImage = UIImageView()
    private let justPlusBookView = JustPlustView()
    private let bookSearchButton = UIButton()
    private let bookTitle = UILabel()
    private let bookDescriptionHeader = UILabel()
    private let bookDescription = UILabel()
    
    private let bookDivisionContentLine = UIView()
    private let datePickerHeader = UILabel()
    private let datePicker = UIDatePicker()
    private let limitPeopleHeader = UILabel()
    private let limitPeople = UITextField()
    private let roomTitleView = UIView()
    private let roomTitle = UITextField()
    private let roomContentView = UIView()
    private let roomContent = UITextView()
    
    private let disposeBag = DisposeBag()
    private let vm = RoomCreateVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleBindDate()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "챌린지 방 만들기"
        
    }
    override func bindData() {
        let saveButtonRx = saveItem.rx.tap
            .withUnretained(self)
            .map { owner, _ in owner.bookImage.image?.jpegData(compressionQuality: 0.5) }
        
        let getbookId = PublishSubject<String>()
        let input = RoomCreateVM.Input(getbookId: getbookId, datePickerTap: datePicker.rx.date, limitPeople: limitPeople.rx.text.orEmpty, roomTitle: roomTitle.rx.text.orEmpty, roomContent: roomContent.rx.text.orEmpty, saveButtonTap: saveButtonRx)

        let output = vm.transform(input: input)
        output.bookInfor
            .bind(with: self) { owner, book in
                owner.setUpBookData(book: book)
                print(book.postURL)
            }.disposed(by: disposeBag)
        output.isSaveTap
            .bind(with: self) { owner, isEnable in
                print(isEnable)
                owner.setUpSaveButton(isEnable)
            }.disposed(by: disposeBag)
        output.finshNetwork
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
        output.netwrokErr
            .bind(with: self) { owner, err in
                owner.simpleAlert(type: err)
            }.disposed(by: disposeBag)
            
        bookSearchButton.rx.tap //서치버튼 누르면 책 검색뷰로 이동
            .bind(with: self) { owner, _ in
                let vc = BookSearchVC()
                vc.vm.compltionBookId = { id in
                    getbookId.onNext(id)
                }
                owner.pushViewController(view: vc)
            }.disposed(by: disposeBag)
        
    }
    private func simpleBindDate() {
        roomContent.rx.didBeginEditing //내용 텍스트필드 플레이스홀더로 만들기
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
        contentView.addSubview(datePickerHeader)
        contentView.addSubview(datePicker)
        contentView.addSubview(limitPeopleHeader)
        contentView.addSubview(limitPeople)
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
    func setUpSaveButton(_ state: Bool) {
        saveItem.isEnabled = state
        if state { //눌를 수 있음
            saveItem.tintColor = .font
        }else {//못눌르는 상태
            saveItem.tintColor = .clightGray
        }
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
        datePickerHeader.snp.makeConstraints { make in
            make.centerY.equalTo(datePicker)
            make.leading.equalTo(contentView).inset(15)
        }
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(bookDivisionContentLine.snp.bottom).offset(15)
            make.trailing.equalTo(contentView).inset(15)
            make.height.equalTo(44)
        }
        limitPeopleHeader.snp.makeConstraints { make in
            make.centerY.equalTo(limitPeople)
            make.leading.equalTo(contentView).inset(15)
        }
        limitPeople.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(15)
            make.trailing.equalTo(contentView).inset(15)
            make.height.equalTo(44)
        }
        roomTitleView.snp.makeConstraints { make in
            make.top.equalTo(limitPeople.snp.bottom).offset(10)
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
            make.bottom.equalTo(contentView).inset(40) //맨 밑에 이거 넣주삼
        }
        roomContent.snp.makeConstraints { make in
            make.edges.equalTo(roomContentView).inset(10)
        }
    }
    func setUpContentView() {
        bookDivisionContentLine.backgroundColor = .darkBoarder
        setUpDatePicker()

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
        
        limitPeopleHeader.text = "참가 인원 선택 - 인원 2~20명"
        limitPeople.placeholder = "숫자만 입력!"
        limitPeople.keyboardType = .numberPad
        limitPeople.contentMode = .right
    }
    func setUpDatePicker() {
        datePickerHeader.text = "챌린지 종료일"
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        //datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        
        var components = DateComponents()
        components.day = 1 //현재 시간 기준으로 최소기간 지정해주기
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        datePicker.minimumDate = minDate
    }
}
