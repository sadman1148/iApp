//
//  ViewController.swift
//  iMovie
//
//  Created by Sadman on 5/5/25.
//

import UIKit

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let moviesVc = UINavigationController(rootViewController: MoviesVC())
        let showsVc = UINavigationController(rootViewController: ShowsVC())
        let searchVc = UINavigationController(rootViewController: SearchVC())
        let qrVc = UINavigationController(rootViewController: QRVC())
        
        moviesVc.title = "Movies"
        showsVc.title = "Shows"
        searchVc.title = "Search"
        qrVc.title = "QR"
        
        moviesVc.tabBarItem.image = UIImage(systemName: "film")
        showsVc.tabBarItem.image = UIImage(systemName: "tv")
        searchVc.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        qrVc.tabBarItem.image = UIImage(systemName: "qrcode.viewfinder")
        
        tabBar.tintColor = .label
        
        setViewControllers([moviesVc, showsVc, searchVc, qrVc], animated: true)
    }

}

