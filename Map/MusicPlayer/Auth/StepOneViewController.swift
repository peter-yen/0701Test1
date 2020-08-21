//
//  StepOneViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/18.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class StepOneViewController: UIViewController {
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var progressBarImageView: UIImageView!
    var nextStepButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(40)
            m.top.equalTo(view.snp.top).offset(30)
        }
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        emailTextField.backgroundColor = .systemGray2
        emailTextField.snp.makeConstraints { (m) in
            m.height.equalTo(30)
            m.width.equalToSuperview()
            m.centerX.equalToSuperview()
            m.top.equalTo(emailLabel.snp.bottom).offset(30)
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
