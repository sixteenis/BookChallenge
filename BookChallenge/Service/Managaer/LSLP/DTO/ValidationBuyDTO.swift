//
//  validationBuyDTO.swift
//  BookChallenge
//
//  Created by 박성민 on 9/1/24.
//

import Foundation

struct validationBuyBody: Encodable {
    let imp_uid: String
    let post_id: String
}

struct ValidationBuyDTO: Decodable {
    let buyer_id: String
    let post_id: String
    let merchant_uid: String
    let productName: String
    let price: Int
    let paidAt: String
    
}
