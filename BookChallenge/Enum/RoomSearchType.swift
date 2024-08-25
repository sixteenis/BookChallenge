//
//  RoomSearchType.swift
//  BookChallenge
//
//  Created by 박성민 on 8/25/24.
//

import Foundation
@frozen
enum RoomSearchType {
    case all
    case searchId(hashTag: String)
}
