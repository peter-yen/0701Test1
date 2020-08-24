//
//  StepThreeViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/23.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class StepThreeViewController: RegisterBasicViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "名稱"
        textField.placeholder = "請輸入名稱"
        finishButton.setTitle("註冊完成", for: .normal)
        progressView.progress = 1.0
        finishButton.addTarget(self, action: #selector(finishButtonDidTap), for: .touchUpInside)
    }
    
    @objc func finishButtonDidTap() {
        dismiss(animated: true, completion: nil)
        
    }
    
}
