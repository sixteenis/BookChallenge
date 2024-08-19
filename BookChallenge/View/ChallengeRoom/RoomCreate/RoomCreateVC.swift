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
                owner.fetchImage(imageView: owner.bookImage, imageURL: book.cover)
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
            make.bottom.equalTo(contentView)
        }
    }
    override func setUpView() {
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
    
                
        let item = UIBarButtonItem(image: UIImage(systemName: "xmark"),style: .plain,  target: self, action: #selector(xbuttonTap))
        let saveItem = UIBarButtonItem(title: "게시하기",style: .plain,  target: self, action: #selector(saveButtonTap))
        navigationItem.leftBarButtonItem = item
        navigationItem.rightBarButtonItem = saveItem
        
    }
    
}
private extension RoomCreateVC {
    @objc func xbuttonTap() {
        dismiss(animated: true)
    }
    @objc func saveButtonTap() {
        print("저장")
    }
}
