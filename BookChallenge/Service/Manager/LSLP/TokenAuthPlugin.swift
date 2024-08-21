//
//  TokenAuthPlugin.swift
//  BookChallenge
//
//  Created by 박성민 on 8/20/24.
//
import Foundation
import Moya

final class TokenAuthPlugin: PluginType {
    typealias accessToken = () -> String?
    
    let tokenClosure: () -> String?
    
    init(tokenClosure: @escaping () -> String?) {
        self.tokenClosure = tokenClosure
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard
              let token = tokenClosure(),
              let target = target as? CatchErrorTargetType,
              target.needsToken
            else {
              return request
            }

            var request = request
            request.addValue(token, forHTTPHeaderField: "Authorization")
            return request
    }
}
