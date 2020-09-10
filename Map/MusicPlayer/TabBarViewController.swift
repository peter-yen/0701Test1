//
//  TabBarViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupController()
        
    }
    
    override func viewDidAppear(_ animated: Bool) { //程式跑的時間太快，在viewDidLoad打會出現不及
        super.viewDidAppear(animated)
        print("viewDidApear")
        
        if let user = Auth.auth().currentUser {
            view.makeToast("Nice to meet you")
        } else {
            let authViewController = AuthViewController()
            let authNavigationController = UINavigationController(rootViewController: authViewController)
            authNavigationController.isModalInPresentation = true
            //上面的是，present的視窗不會被拉下來
            //   authViewController.modalPresentationStyle = .fullScreen
            present(authNavigationController, animated: true, completion: nil)
        }
        
    }
    func setupController() {
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem.image = UIImage(named: "search")
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.image = UIImage(named: "iosph")
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        let mapViewController = MapViewController()
        mapViewController.tabBarItem.image = UIImage(named: "home")
        
        
        self.viewControllers = [searchNavigationController, mapViewController, profileNavigationController]
        
    }
    
}
