//
//  TabBarViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let newSongViewController = NewSongViewController()
        print(newSongViewController.navigationController)
        newSongViewController.tabBarItem.image = UIImage(named: "search")
        
        let profileViewController = ProfileViewController()
        
        profileViewController.tabBarItem.image = UIImage(named: "iosph")
        
        viewControllers = [newSongViewController, profileViewController]
        

        
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
//                    authViewController.modalPresentationStyle = .fullScreen
            present(authNavigationController, animated: true, completion: nil)
        }

    }
    
}
