//
//  EditProfileQuery.swift
//  BookChallenge
//
//  Created by 박성민 on 8/18/24.
//

import Foundation

struct EditProfileQuery: Encodable {
    let nick: String?
    let profile: Data?
}
