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
        
        
        titleLabel.text = "電子郵件"
        textField.placeholder = "請輸入電子郵件"
        progressView.progress = 0.33
        finishButton.addTarget(self, action: #selector(finishButtonDidTap), for: .touchUpInside)
    }
    
    @objc func finishButtonDidTap() {
        let stepTwoViewController = StepTwoViewController()
        if let text = textField.text {
            stepTwoViewController.email = text
        }
        self.navigationController?.pushViewController(stepTwoViewController, animated: true)
        
    }
}
