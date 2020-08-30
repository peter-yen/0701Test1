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
    var city: String
    var introduction: String
    var phone: String
    var district: String
    var px: Double
    var py: Double
    var keyword: String
    var picture1: String
    var address: String
    var description: String
    var travellinginfo: String
    var opentime: String
   
    init(dictionary: [String: Any]) {
        self.id = dictionary["Id"] as! String
        self.name = dictionary["Name"] as! String
        self.introduction = dictionary["Toldescribe"] as! String
        self.phone = dictionary["Tel"] as! String
        if let region = dictionary["Region"] as? String {
            self.city = region
        } else {
            self.city = ""
        }
        if let town = dictionary["Town"] as? String {
            self.district = town
        } else {
            self.district = ""
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
        self.address = dictionary["Add"] as! String
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
    func dictionary() -> [String: Any] {
        let dictionary: [String: Any] = ["id": self.id,
                          "name": self.name,
                          "introduction": self.introduction,
                          "phone": self.phone,
                          "city": self.city,
                          "district": self.district,
                          "px": self.px,
                          "py": self.py,
                          "keyword": self.keyword,
                          "picture1": self.picture1,
                          "description": self.description,
                          "travellinginfo": self.travellinginfo,
                          "opentime": self.opentime,
                          "address": self.address]
        return dictionary
    }
    
    
    
}
