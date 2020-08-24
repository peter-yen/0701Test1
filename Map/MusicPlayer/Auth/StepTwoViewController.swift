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
    var progressView: UIProgressView!
    var nextStepButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLayout()
        
        
    }
    @objc func nextStepButtonDidTap() {
        let stepThreeViewController = StepThreeViewController()
        self.navigationController?.pushViewController(stepThreeViewController, animated: true)
        
    }
    func configureLayout() {
        passwordLabel = UILabel()
        view.addSubview(passwordLabel)
        passwordLabel.font = .systemFont(ofSize: 22)
        passwordLabel.text = "密碼"
        passwordLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(15)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.placeholder = "請輸入密碼"
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingChanged), for: .editingChanged)
        passwordTextField.snp.makeConstraints { (m) in
            //            m.height.equalTo(50)
            //            m.width.equalTo(390)
            //            m.centerX.equalToSuperview()
            m.leading.equalTo(passwordLabel.snp.leading)
            m.top.equalTo(passwordLabel.snp.bottom).offset(10)
        }
        
        nextStepButton = UIButton()
        view.addSubview(nextStepButton)
        nextStepButton.backgroundColor = .systemRed
        nextStepButton.setTitle("下一步", for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStepButtonDidTap), for: .touchUpInside)
        nextStepButton.isEnabled = false
        nextStepButton.alpha = 0.3 
        nextStepButton.snp.makeConstraints { (m) in
            m.width.equalTo(250)
            m.height.equalTo(50)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
        
        progressView = UIProgressView()
        view.addSubview(progressView)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        progressView.tintColor = .black
        progressView.progress = 0.66
        progressView.snp.makeConstraints { (m) in
            m.width.equalTo(300)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.top.equalTo(nextStepButton.snp.bottom).offset(15)
        }
        
    }
    @objc func passwordTextFieldEditingChanged() {
        if let text = passwordTextField.text {
            if text.isEmpty == true {
                nextStepButton.isEnabled = false
                nextStepButton.alpha = 0.3
            } else {
                nextStepButton.isEnabled = true
                nextStepButton.alpha = 1
                
            }

    }
    
    }
    
    
}

extension StepTwoViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
