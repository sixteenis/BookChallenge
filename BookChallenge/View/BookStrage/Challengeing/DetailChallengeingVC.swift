//
//  DetailChallengeingVC.swift
//  BookChallenge
//
//  Created by 박성민 on 9/2/24.
//

import UIKit
import SnapKit

final class DetailChallengeingVC: BaseViewController, FetchImageProtocol {
    private let bookImage = UIImageView()
    private let bookTitle = UILabel()
    private let datePer = PercentView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUpHierarchy() {
        view.addSubview(bookImage)
        view.addSubview(bookTitle)
        view.addSubview(datePer)
    }
    override func setUpLayout() {
        bookImage.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(80)
            make.height.equalTo(120)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImage)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        datePer.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(30)
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
      
        
    }
    
    override func setUpView() {
        fetchLSLPImage(imageView: bookImage, imageURL: "")
        bookTitle.text = "냠냠이의 하루"
        datePer.setUpDate(total: 100, now: 50, left: "냠", right: "냥냥이")
    }
    
}
