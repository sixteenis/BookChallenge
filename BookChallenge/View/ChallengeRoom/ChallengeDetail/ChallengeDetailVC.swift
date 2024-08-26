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

final class ChallengeDetailVC: BaseViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createProfile.layer.cornerRadius = 15
    }
    
    override func setUpHierarchy() {
        view.addSubview(scrollView)
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
        setUpBookLayout()
        setUpContentLayout()
    }
    override func setUpView() {
        bookImage.layer.borderColor = UIColor.boarder.cgColor
        bookImage.layer.borderWidth = 1
        
        bookTitle.font = .boldFont16
        bookTitle.numberOfLines = 1
        bookTitle.textColor = .font
        bookTitle.textAlignment = .center
        
        bookDescription.numberOfLines = 3
        bookDescription.textColor = .font
        bookDescription.font = .font14
        
        bookImage.image = UIImage.noBookImage
        
        createProfile.image = UIImage.noBookImage
        createProfile.layer.masksToBounds = true
        createProfile.layer.borderWidth = 1
        createProfile.layer.borderColor = UIColor.boarder.cgColor
        
        createNick.font = .boldFont14
        
        roomTitle.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        roomContent.font = .font14
        
        bookTitle.text = "감자~~~~~~"
        bookDescription.text = "오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시\n쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오\n늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~오늘 저녁 8시쯤 같이 뛰실뿐~"
        seeMoreDescriptionButton.setTitle("펼치기 🔽", for: .normal)
        seeMoreDescriptionButton.setTitleColor(.font, for: .normal)
        
        
        
        createNick.text = "고구마"
        limitPerson.setUpData(backColor: .clightGray, title: "5/10", image: nil)
        roomTitle.text = "같이 해영"
        roomContent.text = "asdlkjalkdjalksdjaksdjlasjdlkasd"
        rLine.backgroundColor = .clightGray
        lLine.backgroundColor = .clightGray
        seeMoreDescriptionButton.rx.tap
            .bind(with: self) { owner, _ in
                if owner.bookDescription.numberOfLines == 3 {
                    owner.bookDescription.numberOfLines = 0
                }else {
                    owner.bookDescription.numberOfLines = 3
                }
                
            }
    }
    
    
}

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
            make.height.equalTo(2)
        }
        rLine.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(15)
            make.leading.equalTo(seeMoreDescriptionButton.snp.trailing).offset(10)
            make.height.equalTo(2)
            make.centerY.equalTo(seeMoreDescriptionButton)
        }
        seeMoreDescriptionButton.snp.makeConstraints { make in
            make.centerX.equalTo(bookDescription.snp.centerX)
            make.centerY.equalTo(bookDescription.snp.bottom).offset(25)
        }
    }
    func setUpContentLayout() {
        createProfile.snp.makeConstraints { make in
            make.top.equalTo(bookDescription.snp.bottom).offset(55)
            make.leading.equalTo(contentView).inset(15)
            make.size.equalTo(60)
        }
        createNick.snp.makeConstraints { make in
            make.top.equalTo(limitPerson.snp.bottom).offset(5)
            make.leading.equalTo(createProfile.snp.trailing).offset(10)
        }
        limitPerson.snp.makeConstraints { make in
            make.centerY.equalTo(createProfile).offset(-20)
            make.leading.equalTo(createProfile.snp.trailing).offset(10)
        }
        deadline.snp.makeConstraints { make in
            make.centerY.equalTo(createProfile).offset(-20)
            make.leading.equalTo(limitPerson.snp.trailing).offset(10)
        }
        roomTitle.snp.makeConstraints { make in
            make.top.equalTo(createProfile.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        roomContent.snp.makeConstraints { make in
            make.top.equalTo(roomTitle.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).inset(40) //맨 밑에 이거 넣주삼
        }
    }
}
