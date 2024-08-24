//
//  BaseCollectioViewCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

class BaseCollectioViewCell: UICollectionViewCell, FetchImageProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .viewBackground
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
