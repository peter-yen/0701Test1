//
//  MainItem.swift
//  ChapterTest6
//
//  Created by 嚴啟睿 on 2020/7/24.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class MainItem: NSObject {
    var text:String
    var checked:Bool
    
    
    init(text:String,checked:Bool){
    self.text=text
    self.checked=checked
    }
    
    
    func toggleChecked() {
        self.checked = !self.checked
    }
//    var arrdata = [MainItem]()
//    
//    func onCreateData() {
//        for i in 0...4 {
//            var item = MainItem(text: "資料: \(i)", checked: true)
//            arrdata.append(item)
        
    

}
