//
//  AladinTargetType.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//
import Foundation
import Alamofire


protocol AladinTargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String]? { get }
    var parameters: [String:Any]? { get }
    var queryItmes: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension AladinTargetType { //AF.request를 줄임 ㅇㅇ
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        url.appendPathComponent(path)
        if let parameters = parameters {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: "\(value)")
            }
            url = urlComponents?.url ?? url
        }
        var request = URLRequest(url: url)
        request.method = method
        request.allHTTPHeaderFields = header
        request.httpBody = body
        return request
    }
}

