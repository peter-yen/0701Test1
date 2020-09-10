//
//  Spot.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation

enum CityEnum: String {
    
    case TTH = "臺東縣"
    case HLH = "花蓮縣"
    case ILH = "宜蘭縣"
    case TYH = "桃園市"
    case TNH = "臺南市"
    
}

class Spot {
    
    var id: String
    var name: String
    var city: String?
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
   
    init(firestoreDictionary: [String: Any]) {
        self.id = firestoreDictionary["id"] as! String
        self.name = firestoreDictionary["name"] as! String
        self.city = firestoreDictionary["city"] as? String
        self.introduction = firestoreDictionary["introduction"] as! String
        self.phone = firestoreDictionary["phone"] as! String
        self.district = firestoreDictionary["district"] as! String
        self.px = firestoreDictionary["px"] as! Double
        self.py = firestoreDictionary["py"] as! Double
        self.keyword = firestoreDictionary["keyword"] as! String
        self.picture1 = firestoreDictionary["picture1"] as! String
        self.address = firestoreDictionary["address"] as! String
        self.description = firestoreDictionary["description"] as! String
        self.travellinginfo = firestoreDictionary["travellinginfo"] as! String
        self.opentime = firestoreDictionary["opentime"] as! String
        
        
        
    }
    
    
    
    
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["Id"] as! String
        self.name = dictionary["Name"] as! String
        self.introduction = dictionary["Toldescribe"] as! String
        self.phone = dictionary["Tel"] as! String
        self.city = dictionary["Region"] as? String
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

extension Spot: Equatable {}

func ==(left: Spot, right: Spot) -> Bool {
    return left.id == right.id
}

