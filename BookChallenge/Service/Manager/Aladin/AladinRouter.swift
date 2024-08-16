//
//  AladinRouter.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation
import Alamofire
enum AladinRouter {
    case fetchBestseller
    case searchBook
    case searchBookId
}
extension AladinRouter: AladinTargetType {
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    var parameters: [String : Any]? {
        switch self {
        case .fetchBestseller:
            let parametrs = [
                AladinParam.key: Aladin.key,
                AladinParam.QueryType: "Bestseller",
                AladinParam.output: "JS",
                AladinParam.version: "20131101",
                AladinParam.searchTarget: "Book"
            ]
            return parametrs
        case .searchBook:
            return nil
        case .searchBookId:
            return nil
        }
    }
    
    var queryItmes: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
        
    }
    
    var baseURL: String {
        return Aladin.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchBestseller:
            "ItemList.aspx"
        case .searchBook:
            "ItemSearch.aspx"
        case .searchBookId:
            "ItemLookUp.aspx"
        }
    }
    var header: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
