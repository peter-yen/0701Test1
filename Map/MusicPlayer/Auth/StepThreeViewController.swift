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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "名稱"
        textField.placeholder = "請輸入名稱"
        finishButton.setTitle("註冊完成", for: .normal)
        progressView.progress = 1.0
        finishButton.addTarget(self, action: #selector(finishButtonDidTap), for: .touchUpInside)
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
                        
                        if let uid = Auth.auth().currentUser?.uid {
                            Firestore.firestore().collection("Users").document(uid).setData(user.dictionary()) { (error) in
                                print("error: \(error)")
                                self.view.makeToast("Succes")
                                self.dismiss(animated: true, completion: nil)
                            } // user.dictionary 自創的 UserModel 屬性有name, 所以 Firebase 有存到name
                        }
                        
                    }
                    
                }
                
            }
        }
        

        
    }
    
}
