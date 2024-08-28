//
//  PointButton.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

class PointButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.mainColor
        layer.cornerRadius = 10
    }
    func setUpTitle(type: JoinButtonType) {
        setTitle(type.rawValue, for: .normal)
        backgroundColor = type.backColor
        
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
