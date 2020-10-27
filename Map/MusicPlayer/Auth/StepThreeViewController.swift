//
//  StepThreeViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/23.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore
class StepThreeViewController: RegisterBasicViewController {
    var user: User?
    convenience init(email:String, password:String) {
        self.init()
        let user = User(email: email, name: "", password: password)
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layouts(title: "名稱", placeholder: "請輸入名稱", progress: 1.0, button: #selector(finishButtonDidTap))
        
        self.finishButton.setTitle("註冊完成", for: .normal)
    }
    
    @objc func finishButtonDidTap() {
        if let name = textField.text {
            if let user = user {
                user.name = name
                
                print("\(user.dictionary())")
                Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
                    
                    print("result: \(result), error: \(error)")
                    if let error = error {
                        self.view.makeToast(error.localizedDescription)
                    } else {
                        // user.dictionary(): User -> Dictionary
                        if let uid = Auth.auth().currentUser?.uid {
                            let userDict = user.dictionary()
                             API.shared.userRef(uid: uid).setData(userDict) { (error) in
                                if let error = error {
                                    self.view.makeToast(error.localizedDescription)
                                } else {
                                
                                self.view.makeToast("Succes")
                                self.dismiss(animated: true, completion: nil)
                                }
                            } // setData 型別只吃 [String: Any]
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
}
