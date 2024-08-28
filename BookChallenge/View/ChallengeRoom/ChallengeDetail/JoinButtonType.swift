//
//  JoinButtonType.swift
//  BookChallenge
//
//  Created by 박성민 on 8/28/24.
//

import UIKit

enum JoinButtonType: String {
    case canJoin = "참가하기"
    case alreadyJoin = "참여 중"
    case cannotJoin = "참여 불가"
    
    var backColor: UIColor {
        switch self {
        case .canJoin:
            return UIColor.mainColor
        default:
            return UIColor.systemRed
            
        }
    }
}
