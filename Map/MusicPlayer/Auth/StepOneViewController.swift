//
//  StepOneViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/18.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

class StepOneViewController: RegisterBasicViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layouts(title: "電子郵件", placeholder: "請輸入電子郵件", progress: 0.33, button: #selector(finishButtonDidTap))
    }
    
    @objc func finishButtonDidTap() {
        if let text = textField.text {
            let stepTwoViewController = StepTwoViewController(email: text)
            self.navigationController?.pushViewController(stepTwoViewController, animated: true)
        }
        
    }
}
