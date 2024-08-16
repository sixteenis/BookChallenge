//
//  ChangeView.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit

protocol ChangeView {
    func moveNextView(view: UIViewController)
}

extension ChangeView {
    func moveNextView(view: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = view
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
}