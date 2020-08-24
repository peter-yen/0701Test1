//
//  StepThreeViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/23.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class StepThreeViewController: UIViewController {

    var nameLabel: UILabel!
    var nameTextfield: UITextField!
    var progressBarImageView: UIImageView!
    var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 22)
        nameLabel.text = "名稱"
        nameLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(15)
            m.top.equalTo(view.snp.top).offset(85)
        }
        
        nameTextfield = UITextField()
        nameTextfield.delegate = self
        view.addSubview(nameTextfield)
//        nameTextfield.backgroundColor = .systemGray2
        nameTextfield.placeholder = "請輸入暱稱"
        nameTextfield.snp.makeConstraints { (m) in
            m.height.equalTo(50)
            m.width.equalTo(390)
            m.centerX.equalToSuperview()
            m.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.setTitle("註冊完成", for: .normal)
        registerButton.backgroundColor = .systemRed
        registerButton.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
        registerButton.snp.makeConstraints { (m) in
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
            m.top.equalTo(registerButton.snp.bottom).offset(15)
        }
        
        
        
    }
    @objc func registerButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
        
    }
    

  
}

extension StepThreeViewController: UITextFieldDelegate {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
    
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
}
