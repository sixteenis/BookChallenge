//
//  TabBarController.swift
//  BookChallenge
//
//  Created by 박성민 on 8/15/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .systemGray6
        LSLPNetworkManager.shared.requestUserProfile()

        let main = MainVC()
        let bookstorage = BookStorageVC()
        let challengeRoom = ChallengeRoomVC()

        let mainNav = UINavigationController(rootViewController: main)
        mainNav.tabBarItem = UITabBarItem(title: "홈", image: .mainTap, tag: 0)
        
        let bookstorageNav = UINavigationController(rootViewController: bookstorage)
        bookstorageNav.tabBarItem = UITabBarItem(title: "서재", image: .bookStrageTap, tag: 1)
        
        let challengeRoomNav = UINavigationController(rootViewController: challengeRoom)
        challengeRoomNav.tabBarItem = UITabBarItem(title: "챌린지 방", image: .challengeRoomTap, tag: 2)
        
        setViewControllers([mainNav,bookstorageNav, challengeRoomNav], animated: false)
    }
}
