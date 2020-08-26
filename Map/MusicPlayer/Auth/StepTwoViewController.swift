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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "密碼"
        textField.placeholder = "請輸入密碼"
        textField.isSecureTextEntry = true //密碼隱藏
        progressView.progress = 0.66
        finishButton.addTarget(self, action: #selector(finishButtonDidTap), for: .touchUpInside)
    }
    
    @objc func finishButtonDidTap() {
        let stepThreeViewController = StepThreeViewController()
        if let password = textField.text {
            let user = User(email: email, name: "", password: password)
            stepThreeViewController.user = user
           
        }
        self.navigationController?.pushViewController(stepThreeViewController, animated: true)
        
    }
}
