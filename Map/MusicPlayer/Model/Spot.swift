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
    var picture1: String
    var add: String
    var description: String
    var travellinginfo: String
    var opentime: String
   
    init(dictionary: [String: Any]) {
        self.id = dictionary["Id"] as! String
        self.name = dictionary["Name"] as! String
        self.toldescribe = dictionary["Toldescribe"] as! String
        self.tel = dictionary["Tel"] as! String
        if let region = dictionary["Region"] as? String {
            self.region = region
        } else {
            self.region = ""
        }
        if let town = dictionary["Town"] as? String {
            self.town = town
        } else {
            self.town = ""
        }
        self.px = dictionary["Px"] as! Double
        self.py = dictionary["Py"] as! Double
        if let keyword = dictionary["Keyword"] as? String {
            self.keyword = keyword
        } else {
            self.keyword = ""
        }
        if let picture1 = dictionary["Picture1"] as? String {
            self.picture1 = picture1
        } else {
            self.picture1 = ""
        }
        self.add = dictionary["Add"] as! String
        if let description = dictionary["Description"] as? String {
            self.description = description
        } else {
            self.description = ""
        }
        if let travellinginfo = dictionary["Travellinginfo"] as? String {
            self.travellinginfo = travellinginfo
        } else {
            self.travellinginfo = ""
        }
        if let opentime = dictionary["Opentime"] as? String {
            self.opentime = opentime
        } else {
            self.opentime = ""
        }
    }
    
    
    
}
