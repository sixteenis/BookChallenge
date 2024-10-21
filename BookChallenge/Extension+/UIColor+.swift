//
//  UIColor+.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

extension UIColor {
    static let mainColor = UIColor(red: 60/255, green: 185/255, blue: 239/255, alpha: 1.0) // #3CB9EF
    static let font = UIColor.black
    static let placeholder = UIColor.lightGray
    static let viewBackground = UIColor.white
    
    static let clightGray = UIColor.lightGray
    static let collectionBackground = UIColor.white
    //UIColor.systemGray6
    static let boarder = UIColor.systemGray6
    static let grayBackground  = UIColor.systemGray6
    static let darkBoarder = UIColor.darkGray
    static let line = UIColor.systemGray5
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
