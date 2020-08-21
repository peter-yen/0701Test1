//
//  StepTwoViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/19.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class StepTwoViewController: UIViewController {
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var progressBarImageView: UIImageView!
    var nextStepButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordLabel = UILabel()
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(40)
            m.top.equalTo(view.snp.top).offset(30)
        }
        
        passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        passwordTextField.backgroundColor = .systemGray2
        passwordTextField.snp.makeConstraints { (m) in
            m.height.equalTo(30)
            m.width.equalToSuperview()
            m.centerX.equalToSuperview()
            m.top.equalTo(passwordLabel.snp.bottom).offset(30)
        }
        
        nextStepButton = UIButton()
        view.addSubview(nextStepButton)
        nextStepButton.backgroundColor = .systemRed
        nextStepButton.snp.makeConstraints { (m) in
            m.width.equalTo(250)
            m.height.equalTo(50)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
        
        progressBarImageView = UIImageView()
        view.addSubview(progressBarImageView)
        progressBarImageView.backgroundColor = .systemGray2
        progressBarImageView.snp.makeConstraints { (m) in
            m.width.equalTo(300)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.top.equalTo(nextStepButton.snp.bottom).offset(15)
        }
        
        
    }
    

  

}
