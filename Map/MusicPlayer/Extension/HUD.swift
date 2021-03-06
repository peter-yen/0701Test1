//
//  HUD.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation
import JGProgressHUD


class HUD {
    static var shared: HUD = HUD()
    var hud: JGProgressHUD?
    
    func showLoading(view: UIView) {
        hud = JGProgressHUD(style: .extraLight)
        
        hud?.contentInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        hud?.textLabel.text = "Loading"
        
        hud?.show(in: view, animated: true)
        
//        hud?.show(in: view)
    }
    func hideLoading() {
        if let hud = hud {
            hud.dismiss(afterDelay: 0.5)
        }
    }
    
}
