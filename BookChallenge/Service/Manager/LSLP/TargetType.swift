//
//  TargetType.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation
import Alamofire
// url, header, paramater, boy, query
protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var parameters: String? { get }
    var queryItmes: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType { //AF.request를 줄임 ㅇㅇ
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var request = try URLRequest(
            url: url.appendingPathComponent(path),
            method: method)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        //request.httpBody = parameters?.data(using: .utf8)
        return request
    }
}

