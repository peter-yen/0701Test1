//
//  Spot.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation

class Spot {
    
    var id: String
    var name: String
    var region: String
    var toldescribe: String
    var tel: String
    var town: String
    var px: Double
    var py: Double
    var keyword: String
    /*
     let id = infoArray["Id"] as? String ,
     let name = infoArray["Name"] as? String ,
     let toldescribe = infoArray["Toldescribe"] as? String ,
     let tel = infoArray["Tel"] as? String ,
     let region = infoArray["Region"] as? String ,
     let town = infoArray["Town"] as? String ,
     let px = infoArray["Px"] as? Double ,
     let py = infoArray["Py"] as? Double  ,
     let keyword = infoArray["Keyword"] as? String
     */
    init(dictionary: [String: Any]) {
        self.id = dictionary["Id"] as! String
        self.name = dictionary["Name"] as! String
        self.toldescribe = dictionary["Toldescribe"] as! String
        self.tel = dictionary["Tel"] as! String
        self.region = dictionary["Region"] as! String
        self.town = dictionary["Town"] as! String
        self.px = dictionary["Px"] as! Double
        self.py = dictionary["Py"] as! Double
        self.keyword = dictionary["Keyword"] as! String
    }
    
    
    
}
