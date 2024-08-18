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

class RoomCreateVC: BaseViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bookImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(bookImage)
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
            make.width.equalTo(100)
            make.height.equalTo(170)
            make.top.horizontalEdges.equalTo(contentView).inset(50)
        }
    }
    override func setUpView() {
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
        
        bookImage.image = UIImage(systemName: "plus")
        
        let item = UIBarButtonItem(image: UIImage(systemName: "xmark"),style: .plain,  target: self, action: #selector(xbuttonTap))
        let saveItem = UIBarButtonItem(title: "게시하기",style: .plain,  target: self, action: #selector(saveButtonTap))
        navigationItem.leftBarButtonItem = item
        navigationItem.rightBarButtonItem = saveItem
        navigationItem.title = "감자국"
    
        
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
