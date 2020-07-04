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
        view.backgroundColor = .green
        
        let vc = MapViewController()
        vc.tabBarItem.image = UIImage(named: "favorite")
        
        //功課：完成0701的作業，於HomeViewController做auto layout
        let vc2 = HomeViewController()
        vc2.tabBarItem.image = UIImage(named: "home")
        
        //功課2：AnimalTableViewController，顯示四種動物的table view
        let vc3 = SearchTableViewController()
        view.backgroundColor = .brown
        vc3.tabBarItem.image = UIImage(named: "search")
        viewControllers = [vc, vc2, vc3]
        
        
        
        
    }
    

   

}
