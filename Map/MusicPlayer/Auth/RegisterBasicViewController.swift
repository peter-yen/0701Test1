//
//  RegisterBasicViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/24.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class RegisterBasicViewController: UIViewController {
    
    var titleLabel: UILabel!
    var textField: UITextField!
    var progressView: UIProgressView!
    var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLayout()
        
    }
    
    
    
    func configureLayout() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        titleLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(15)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        textField = UITextField()
        view.addSubview(textField)
        textField.delegate = self
        textField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)
        textField.snp.makeConstraints { (m) in
            //            m.height.equalTo(50)
            //            m.width.equalTo(390)
            //            m.centerX.equalToSuperview()
            m.leading.equalTo(titleLabel.snp.leading)
            m.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        finishButton = UIButton()
        view.addSubview(finishButton)
        finishButton.backgroundColor = .systemRed
        finishButton.setTitle("下一步", for: .normal)
        
        finishButton.isEnabled = false //按的開關
        finishButton.alpha = 0.3 //透明度
        finishButton.snp.makeConstraints { (m) in
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
            m.top.equalTo(finishButton.snp.bottom).offset(15)
        }
        
    }
    @objc func emailTextFieldEditingChanged() {
        if let text = textField.text {
            if text.isEmpty == true {
                finishButton.isEnabled = false
                finishButton.alpha = 0.3
            } else {
                finishButton.isEnabled = true
                finishButton.alpha = 1
                
            }
        }
        
    }
}
    
    extension RegisterBasicViewController: UITextFieldDelegate {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
            
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
            return true
        }
}


