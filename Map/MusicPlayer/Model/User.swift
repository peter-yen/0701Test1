//
//  User.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/21.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation

class User {
    var email: String
    var name: String
    var password: String
    var isAdmin: Bool
    
    init (email: String, name: String, password: String) {
        self.email = email
        self.name = name
        self.password = password
        self.isAdmin = false
        
    }
    func dictionary() -> [String:Any] {
        let dictionary = ["email": self.email,
                          "name": self.name,
                          "password": self.password]
        return dictionary
        
    }
    
    
    
}
