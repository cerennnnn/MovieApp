//
//  TabBarController.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 14.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem.image = UIImage(systemName: "house")
        home.tabBarItem.title = "Home"
        
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem.image =  UIImage(systemName: "magnifyingglass")
        search.tabBarItem.title = "Search"
        
        tabBar.tintColor = .label
//        tabBar.backgroundColor = .secondarySystemBackground
        setViewControllers([home, search], animated: true)

    }
  
}
