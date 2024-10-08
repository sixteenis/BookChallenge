//
//  SimVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/26/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
final class SimVC: BaseViewController {
    private let bookName = UILabel()
    private let pageTextHeader = UILabel()
    
    private let pageView = UIView()
    private let pageTextFiled = UITextField()
    private let pageTextLabel = UILabel()
    private let maxPage = UILabel()
    
    private let contentHeader = UILabel()
    private let contentView = UIView()
    private let contentLabel = UILabel()
    private let contentTextFiled = UITextView()
    private let button = PointButton(title: "기록하기")
    var completion: (() -> ())?
    private var disposeBag = DisposeBag()
    private var postId = ""
    private var maxPageNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    override func setUpHierarchy() {
        view.addSubview(bookName)
        view.addSubview(pageTextHeader)
        view.addSubview(pageView)
        view.addSubview(pageTextFiled)
        view.addSubview(pageTextLabel)
        view.addSubview(maxPage)
        view.addSubview(contentHeader)
        view.addSubview(contentView)
        view.addSubview(contentTextFiled)
        view.addSubview(contentLabel)
        view.addSubview(button)
    }
    override func setUpLayout() {
        bookName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        pageTextHeader.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(bookName.snp.bottom).offset(20)
        }
        pageView.snp.makeConstraints { make in
            make.top.equalTo(pageTextHeader.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(maxPage.snp.leading).offset(-15)
            make.height.equalTo(33)
        }
        pageTextFiled.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(pageView).inset(15)
            make.centerY.equalTo(pageView)
        }
        pageTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(pageTextFiled)
            make.centerY.equalTo(pageView)
        }
        maxPage.snp.makeConstraints { make in
            make.top.equalTo(pageTextHeader.snp.bottom).offset(10)
            make.centerY.equalTo(pageView)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        contentHeader.snp.makeConstraints { make in
            make.top.equalTo(pageView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(contentHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(90)
        }
        contentTextFiled.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(15)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(22)
            make.leading.equalTo(contentView).inset(20)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(30)
            //make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(36)
        }
        
    }
    override func setUpView() {
        bookName.textAlignment = .center
        bookName.numberOfLines = 1
        bookName.textColor = .font
        
        pageTextHeader.textColor = .font
        pageTextHeader.textAlignment = .left
        pageTextHeader.text = "독서량"
        
        pageView.backgroundColor = .systemGray6
        pageView.layer.borderColor = UIColor.clightGray.cgColor
        pageView.layer.borderWidth = 1
        pageView.layer.cornerRadius = 10
        pageTextFiled.keyboardType = .numberPad
        pageTextFiled.font = .font14
        pageTextLabel.textColor = .placeholder
        pageTextLabel.font = .font14
        
        
        contentHeader.text = "한줄평"
        contentView.backgroundColor = .systemGray6
        contentView.layer.borderColor = UIColor.clightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
        contentTextFiled.backgroundColor = .systemGray6
        contentTextFiled.font = .font13
        contentLabel.text = "짧은 감상평을 남겨보세요. (선택)"
        contentLabel.textColor = .placeholder
        contentLabel.font = .font13
        button.backgroundColor = .mainColor
        
        bind()
        
    }
    private func bind() {
        let network = PublishRelay<CommentsPostInputModel>()
        button.rx.tap
            .bind(with: self) { owner, _ in
                guard let setPage = Int(owner.pageTextFiled.text!) else {
                    owner.simpleAlert(title: "입력 정보를 확인해주세요.")
                    return
                }
                
                if setPage >  owner.maxPageNum {
                    owner.simpleAlert(title: "페이지를 넘었습니다.")
                    return
                }
                let comments = owner.pageTextFiled.text! + UserManager.shared.userId + self.contentTextFiled.text!
                network.accept(CommentsPostInputModel(postId: self.postId, comments: comments))
            }.disposed(by: disposeBag)
        
        pageTextFiled.rx.text.orEmpty
            .bind(with: self) { owner, text in
                owner.pageTextLabel.isHidden = !text.isEmpty
            }.disposed(by: disposeBag)
        contentTextFiled.rx.text.orEmpty
            .bind(with: self) { owner, text in
                owner.contentLabel.isHidden = !text.isEmpty
            }.disposed(by: disposeBag)
        network
            .flatMap {
                LSLPNetworkManager.shared.request(target: .commentsPost(body: .init(content: $0.comments), postId: $0.postId), dto: CommentsDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(_):
                    owner.completion?()
                    owner.dismiss(animated: true)
                case .failure(let err):
                    owner.simpleAlert(title: "다시 시도해 주세요.")
                }
            }.disposed(by: disposeBag)
        
    }
    func setUpView(bookTitle: String, page: Int, totalPage: Int, postId: String) {
        bookName.text = bookTitle
        print(page)
        pageTextLabel.text = "\(page)"
        maxPage.text = "/ \(totalPage)"
        self.postId = postId
        self.maxPageNum = totalPage
    }
}
