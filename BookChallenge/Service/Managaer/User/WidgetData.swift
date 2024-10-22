//
//  WidgetData.swift
//  BookChallenge
//
//  Created by 박성민 on 10/22/24.
//

import Foundation

extension UserDefaults {
    static var groupShared: UserDefaults {
        let appID = "group.com.Sixteenis.BookChallenge.min"
        return UserDefaults(suiteName: appID)!
    }
}
