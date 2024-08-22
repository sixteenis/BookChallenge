//
//  validationEamilModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/21/24.
//

import Foundation

struct ValidationEmailBody: Encodable {
    let email: String
}

struct ValidationEmailDTO: Decodable {
    let message: String
}
