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

class StepOneViewController: UIViewController {
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var progressView: UIProgressView!
    var nextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLayout()
        
    }
    @objc func nextStepButtonDidTap() {
        let stepTwoViewController = StepTwoViewController()
        //        var email = emailTextField.text
        self.navigationController?.pushViewController(stepTwoViewController, animated: true)
        
    }
    func configureLayout() {
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        emailLabel.font = .boldSystemFont(ofSize: 22)
        emailLabel.text = "電子郵件"
        emailLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(15)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.placeholder = "請輸入電子郵件"
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)
        emailTextField.snp.makeConstraints { (m) in
            //            m.height.equalTo(50)
            //            m.width.equalTo(390)
            //            m.centerX.equalToSuperview()
            m.leading.equalTo(emailLabel.snp.leading)
            m.top.equalTo(emailLabel.snp.bottom).offset(10)
        }
        
        nextStepButton = UIButton()
        view.addSubview(nextStepButton)
        nextStepButton.backgroundColor = .systemRed
        nextStepButton.setTitle("下一步", for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStepButtonDidTap), for: .touchUpInside)
        nextStepButton.isEnabled = false //按的開關
        nextStepButton.alpha = 0.3 //透明度
        nextStepButton.snp.makeConstraints { (m) in
            m.width.equalTo(250)
            m.height.equalTo(50)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
        
        progressView = UIProgressView()
        view.addSubview(progressView)
        progressView.clipsToBounds = true //開關
        progressView.layer.cornerRadius = 10 //修邊
        progressView.tintColor = .black
        progressView.progress = 0.33
        progressView.snp.makeConstraints { (m) in
            m.width.equalTo(300)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.top.equalTo(nextStepButton.snp.bottom).offset(15)
        }
        
    }
    @objc func emailTextFieldEditingChanged() {
        if let text = emailTextField.text {
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

extension StepOneViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
