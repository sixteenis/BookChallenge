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
        let date = dateFormatter.date(from: str)
        guard let date else {return Date()}
        return date
    }
    
    static func comparisonDate(to a: Date, form b: Date) -> Int {
        let difference = Calendar.current.dateComponents([.day], from: a, to: b).day ?? 0
        return difference
    }
}
