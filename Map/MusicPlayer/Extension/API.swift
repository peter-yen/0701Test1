//
//  API.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class API {
static let shared: API = API()
    let root = Firestore.firestore()
func userRef(uid: String) -> DocumentReference {
    return root.collection("Users").document(uid)
    
    
    }
}
