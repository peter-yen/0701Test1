//
//  AppDelegate.swift
//  0701
//
//  Created by 嚴啟睿 on 2020/7/1.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()
        let vc = FirstViewController()
        window?.rootViewController = vc


        
        return true
    }

    

}
