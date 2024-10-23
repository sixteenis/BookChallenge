//
//  ChallengeDetailVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/26/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class ChallengeDetailVC: BaseViewController, FetchImageProtocol {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let bookImage = UIImageView()
    private let bookTitle = UILabel()
    private let bookDescription = UILabel()
    private let lLine = UIView()
    private let rLine = UIView()
    private let seeMoreDescriptionButton = UIButton()
    
    private let createProfile = UIImageView()
    private let createNick = UILabel()
    private let limitPerson = CapsuleLabel()
    private let deadline = CapsuleLabel()
    private let roomTitle = UILabel()
    private let roomContent = UILabel()
    
    private let buttonView = UIView()
    private let buyAndJoinButton = BuyButtonView()
    private let joinButton = PointButton(title: "참여하기")
 
    
    private let disposeBag = DisposeBag()
    var vm = ChallengeDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "방 정보 보기"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createProfile.layer.cornerRadius = 15
    }
    
    override func bindData() {
        let join = BehaviorRelay(value: ())
        let input = ChallengeDetailVM.Input(joinButtonTap: join.asObservable(), buyButtonTap: buyAndJoinButton.button.rx.tap)
        let output = vm.transform(input: input)
        
        output.postData
            .bind(with: self) { owner, post in
                owner.setUpPost(model: post)
            }.disposed(by: disposeBag)
        
        output.bookData
            .bind(with: self) { owner, book in
                owner.setUpBook(model: book)
            }.disposed(by: disposeBag)
        output.retrunBeforeErr //이미 하는 중이거나 사라진 방일 때 뒤로 보냄
            .bind(with: self) { owner, message in
                owner.simpleAlert(title: message) {
                    owner.popViewController()
                }
            }.disposed(by: disposeBag)
        output.joinSuccess
            .bind(with: self) { owner, _ in
                owner.simpleToast(text: "참여하기 완료!")  
            }.disposed(by: disposeBag)
        output.joinButton
            .bind(with: self) { owner, type in
                owner.setUpJoinButton(type: type)
            }.disposed(by: disposeBag)
        
        // MARK: - 구매 화면으로 이동하는 로직
        output.buyBook
            .bind(with: self) { owner, buyData in
                let vc = IamportVC()
                vc.buyModel = buyData
                owner.pushViewController(view: vc)
            }.disposed(by: disposeBag)
        
        seeMoreDescriptionButton.rx.tap
            .bind(with: self) { owner, _ in
                if owner.bookDescription.numberOfLines == 3 {
                    owner.bookDescription.numberOfLines = 0
                    owner.seeMoreDescriptionButton.setTitle("접기 🔼", for: .normal)
                    owner.seeMoreDescriptionButton.setTitleColor(.font, for: .normal)
                }else {
                    owner.bookDescription.numberOfLines = 3
                    owner.seeMoreDescriptionButton.setTitle("펼치기 🔽", for: .normal)
                    owner.seeMoreDescriptionButton.setTitleColor(.font, for: .normal)
                }
                
            }.disposed(by: disposeBag)
        joinButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.choiceAlert(title: "참여 하시겠습니까?") {
                    join.accept(())
                }
            }.disposed(by: disposeBag)
            
    }
    
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        view.addSubview(buttonView)
        buttonView.addSubview(buyAndJoinButton)
        buttonView.addSubview(joinButton)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(bookImage)
        contentView.addSubview(bookTitle)
        contentView.addSubview(bookDescription)
        contentView.addSubview(lLine)
        contentView.addSubview(rLine)
        contentView.addSubview(seeMoreDescriptionButton)
        
        contentView.addSubview(createProfile)
        contentView.addSubview(createNick)
        contentView.addSubview(limitPerson)
        contentView.addSubview(deadline)
        contentView.addSubview(roomTitle)
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
        buttonView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view)
            make.height.equalTo(90)
        }
        buyAndJoinButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).inset(5)
            make.leading.equalTo(buttonView).inset(25)
            make.size.equalTo(40)
        }
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).inset(10)
            make.leading.equalTo(buyAndJoinButton.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
        setUpBookLayout()
        setUpContentLayout()
    }
    override func setUpView() {
        buttonView.backgroundColor = .systemGray6
        buyAndJoinButton.backgroundColor = .systemGray6
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.borderWidth = 1
        
        bookTitle.font = .boldFont16
        bookTitle.numberOfLines = 1
        bookTitle.textColor = .font
        bookTitle.textAlignment = .center
        
        bookDescription.numberOfLines = 3
        bookDescription.textColor = .font
        bookDescription.font = .font14
        
        
        createProfile.layer.masksToBounds = true
        createProfile.layer.borderWidth = 1
        createProfile.layer.borderColor = UIColor.boarder.cgColor
        
        createNick.font = .boldFont14
        
        roomTitle.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        roomContent.font = .font14
        
        seeMoreDescriptionButton.setTitle("펼치기 🔽", for: .normal)
        seeMoreDescriptionButton.setTitleColor(.font, for: .normal)
        seeMoreDescriptionButton.titleLabel?.font = .boldFont13
        
        rLine.backgroundColor = .clightGray
        lLine.backgroundColor = .clightGray
    }
    
    
}
private extension ChallengeDetailVC {
    func setUpBook(model: BookModel) {
        fetchImage(imageView: bookImage, imageURL: model.bookURL)
        bookTitle.text = model.title
        bookDescription.text = """
        \n\(model.description)\n\n 작가: \(model.author) \n\n 출판사: \(model.publisher) \n\n 출판일: \(model.pubDate) \n\n 가격: \(model.price) \n\n 페이지 수: \(model.page)
    """
    }
    func setUpPost(model: ChallengePostModel) {
        fetchPrfileImage(imageView: createProfile, imageURL: model.profile)
        createNick.text = model.nick
        limitPerson.setUpData(title: model.limitPerson, image: .limitPerson)
        deadline.setUpData(title: model.deadLine, image: .deadLine)
        roomTitle.text = model.title
        roomContent.text = model.content
        roomContent.numberOfLines = 0
    }
    func setUpJoinButton(type: JoinButtonType) {
        joinButton.setUpTitle(type: type)
        if type == .canJoin {
            joinButton.isEnabled = true
        } else {
            joinButton.isEnabled = false
        }
    }
    
}
// MARK: - 레이아웃 부분
private extension ChallengeDetailVC {
    func setUpBookLayout() {
        bookImage.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(200)
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).inset(10)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        bookDescription.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        lLine.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(15)
            make.trailing.equalTo(seeMoreDescriptionButton.snp.leading).offset(-10)
            make.centerY.equalTo(seeMoreDescriptionButton)
            make.height.equalTo(1)
        }
        rLine.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(15)
            make.leading.equalTo(seeMoreDescriptionButton.snp.trailing).offset(10)
            make.height.equalTo(1)
            make.centerY.equalTo(seeMoreDescriptionButton)
        }
        seeMoreDescriptionButton.snp.makeConstraints { make in
            make.centerX.equalTo(bookDescription.snp.centerX)
            make.centerY.equalTo(bookDescription.snp.bottom).offset(25)
        }
    }
    func setUpContentLayout() {
        createProfile.snp.makeConstraints { make in
            make.top.equalTo(bookDescription.snp.bottom).offset(50)
            make.leading.equalTo(contentView).inset(15)
            make.size.equalTo(60)
        }
        createNick.snp.makeConstraints { make in
            make.bottom.equalTo(createProfile.snp.bottom).offset(-5)
            make.leading.equalTo(createProfile.snp.trailing).offset(10)
        }
        limitPerson.snp.makeConstraints { make in
            make.centerY.equalTo(createProfile).offset(-15)
            make.leading.equalTo(createProfile.snp.trailing).offset(10)
        }
        deadline.snp.makeConstraints { make in
            make.centerY.equalTo(createProfile).offset(-15)
            make.leading.equalTo(limitPerson.snp.trailing).offset(10)
        }
        roomTitle.snp.makeConstraints { make in
            make.top.equalTo(createProfile.snp.bottom).offset(15)
            make.trailing.equalTo(contentView).inset(20)
            make.leading.equalTo(createProfile.snp.leading)
        }
        roomContent.snp.makeConstraints { make in
            make.top.equalTo(roomTitle.snp.bottom).offset(15)
            make.trailing.equalTo(contentView).inset(15)
            make.leading.equalTo(createProfile.snp.leading)
            make.bottom.equalTo(contentView).inset(90) //맨 밑에 이거 넣주삼
        }
    }
}
