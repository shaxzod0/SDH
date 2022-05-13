//
//  TabBarController.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
}

extension TabBarController {
    private func initViews() {
        let mainVC = MainVC()
        let favoriteVC = FavoriteController()
        
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "suit.heart.fill"), selectedImage: UIImage(systemName: "suit.heart.fill"))
        viewControllers = [mainVC,favoriteVC]
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 25
        tabBar.clipsToBounds = true
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
