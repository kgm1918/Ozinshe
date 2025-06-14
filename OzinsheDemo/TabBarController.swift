//
//  TabBarController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupTabs()
    }
    
    func setupTabs(){
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favouriteVC = FavouriteViewController()
        let profileVC = ProfileViewController()
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "homeSelected"))
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), selectedImage: UIImage(named: "searchSelected"))
        favouriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorite"), selectedImage: UIImage(named: "favoriteSelected"))
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profileSelected"))
        let navHome = UINavigationController(rootViewController: homeVC)
        let navSearch = UINavigationController(rootViewController: searchVC)
        let navProfile = UINavigationController(rootViewController: profileVC)
        setViewControllers([navHome, navSearch, favouriteVC, navProfile], animated: true)
    }

}
