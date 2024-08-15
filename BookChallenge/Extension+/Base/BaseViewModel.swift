//
//  BaseViewModel.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
