//
//  TabBarViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    let vc1 = NewSongViewController()
    print(vc1.navigationController)
    vc1.tabBarItem.image = UIImage(named: "search")
    
    let vc2 = UINavigationController(rootViewController: AuthViewController())
    print(vc2.navigationController)
//    vc2.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    vc2.tabBarItem.image = UIImage(named: "iosph")
    
    viewControllers = [vc1, vc2]
    
  }

}
