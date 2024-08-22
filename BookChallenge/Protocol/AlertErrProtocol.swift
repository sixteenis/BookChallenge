//
//  Alert.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import Foundation

protocol AlertErrProtocol: Error {
    var message: String { get }
    //var completion: () -> () { get }
}
