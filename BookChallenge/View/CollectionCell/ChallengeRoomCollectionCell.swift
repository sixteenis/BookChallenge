//
//  ChallengeRoomCollectionCell.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import SnapKit

class ChallengeRoomCollectionCell: BaseCollectioViewCell {
    let testImage = UIImageView()
    
    override func setUpHierarchy() {
        self.addSubview(testImage)
        testImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        testImage.image = .logo
    }
    override func setUpLayout() {
        
    }
    override func setUpView() {
        
    }
}
