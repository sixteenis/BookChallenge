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
class SimVC: BaseViewController {
    let texts = UILabel()
    let button = UIButton()
    let textFiled = UITextField()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUpLayout() {
        view.addSubview(texts)
        view.addSubview(button)
        view.addSubview(textFiled)
        texts.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        //texts.text = "고구마 책입니다"
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        textFiled.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        textFiled.placeholder = "검색하기"
        button.setTitle("버튼", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
    func setUpView(text: String) {
        texts.text = text
    }
}
