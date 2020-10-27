//
//  StepTwoViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/19.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class StepTwoViewController: RegisterBasicViewController {
    var email: String = ""
    convenience init(email: String) {
        self.init()
        self.email = email
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layouts(title: "密碼", placeholder: "請輸入密碼", progress: 0.66, button: #selector(finishButtonDidTap))
        
        self.textField.isSecureTextEntry = true //密碼隱藏
    }
    
    @objc func finishButtonDidTap() {
        if let password = self.textField.text {
            let stepThreeViewController = StepThreeViewController(email: email, password: password)
            self.navigationController?.pushViewController(stepThreeViewController, animated: true)
        }
        
    }
}
