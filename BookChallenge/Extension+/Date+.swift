//
//  Date+.swift
//  BookChallenge
//
//  Created by 박성민 on 8/28/24.
//

import Foundation

extension Date {
    static func asTranformDate(str: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = dateFormatter.date(from: str)
        guard let date else {return Date()}
        return date
    }
    static func asTransformCustomStr(str: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = dateFormatter.date(from: str)
        guard let date else {return ""}
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yy.M.d"
        myDateFormatter.locale = Locale(identifier: "ko_KR")
        let convertStr = myDateFormatter.string(from: date)
        return convertStr
    }
    static func asTransformString(date: Date) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = dateFormatter.string(from: date)
        return date
    }
    
    static func comparisonDate(to a: Date, form b: Date) -> Int {
        let difference = Calendar.current.dateComponents([.day], from: a, to: b).day ?? 0
        return difference
    }
}
