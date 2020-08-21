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

    var vc: UIViewController?
    if let user = Auth.auth().currentUser {
//               let tabbarVC = TabBarViewController()
//               vc = tabbarVC
        view.makeToast("Nice to meet you")
           }else {
               let authVC = AuthViewController()
          vc =  UINavigationController(rootViewController: authVC)
        present(vc!, animated: true, completion: nil)
           }
    
    
    let newSongViewController = NewSongViewController()
    print(newSongViewController.navigationController)
    newSongViewController.tabBarItem.image = UIImage(named: "search")
    
    let profileViewController = ProfileViewController()

    profileViewController.tabBarItem.image = UIImage(named: "iosph")
    
    viewControllers = [newSongViewController, profileViewController]
    
  }

}
