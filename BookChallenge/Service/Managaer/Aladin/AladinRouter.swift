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
    case searchBook(keyword: String, page: Int)
    case searchBookId(itemId: String)
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
                AladinParam.searchTarget: "Book",
                AladinParam.cover: "Big"
            ]
            return parametrs
        case .searchBook(let keyword, let page):
            let paramters: [String:Any] = [
                AladinParam.key: Aladin.key,
                AladinParam.cover: "Big",
                AladinParam.query: keyword,
                AladinParam.start: page,
                AladinParam.output: "JS",
                AladinParam.version: "20131101",
                AladinParam.searchTarget: "Book"
            ]
            return paramters
        case .searchBookId(let id):
            let parametrs = [
                AladinParam.key: Aladin.key,
                AladinParam.itemId: id,
                AladinParam.itemIdType: "ISBN13",
                AladinParam.cover: "Big",
                AladinParam.output: "JS",
                AladinParam.version: "20131101"
            ]
            return parametrs
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
