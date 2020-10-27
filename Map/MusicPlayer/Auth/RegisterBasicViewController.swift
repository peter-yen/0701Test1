//
//  RegisterBasicViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/24.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class RegisterBasicViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
       let tl = UILabel()
        tl.font = .boldSystemFont(ofSize: 22)
        return tl
    }()
    var textField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    var progressView: UIProgressView = {
       let pv = UIProgressView()
        pv.clipsToBounds = true //開關
        pv.layer.cornerRadius = 10 //修邊
        pv.tintColor = .black
        pv.progress = 0.33
        return pv
    }()
    var finishButton: UIButton = {
       let fb = UIButton()
        fb.backgroundColor = .systemRed
        fb.clipsToBounds = true
        fb.layer.cornerRadius = 20
        fb.setTitle("下一步", for: .normal)
        fb.isEnabled = false //按的開關
        fb.alpha = 0.3 //透明度
        return fb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupSubviews()
        
    }
    
    func layouts(title: String,
                placeholder: String,
                progress: Float,
                button: Selector) {
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        self.progressView.progress = progress
        self.finishButton.addTarget(self, action: button, for: .touchUpInside)
        
    }

    func setupSubviews() {
        view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(15)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        view.addSubview(textField)
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)
        self.textField.snp.makeConstraints { (m) in
            m.leading.equalTo(titleLabel.snp.leading)
            m.top.equalTo(titleLabel.snp.bottom).offset(10)
            m.width.equalToSuperview()
        }
        view.addSubview(finishButton)
        self.finishButton.snp.makeConstraints { (m) in
            m.width.equalTo(250)
            m.height.equalTo(50)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
        view.addSubview(progressView)
        self.progressView.snp.makeConstraints { (m) in
            m.width.equalTo(300)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.top.equalTo(finishButton.snp.bottom).offset(15)
        }
        
    }
    @objc func emailTextFieldEditingChanged() {
        if let text = textField.text {
            if text.isEmpty == true {
                self.finishButton.isEnabled = false
                self.finishButton.alpha = 0.3
            } else {
                self.finishButton.isEnabled = true
                self.finishButton.alpha = 1
                
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


