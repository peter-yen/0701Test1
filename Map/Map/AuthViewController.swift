//
//  TextFiledTestViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/23.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
//AuthViewController
class AuthViewController: UIViewController {
  var emailTextField: UITextField! //emailTextField
  var passwordTextField: UITextField! //passwordTextField
  var loginButton: UIButton! //loginButton
    var registerButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    emailTextField = UITextField()
    emailTextField.backgroundColor = .systemGray2
    emailTextField.delegate = self
    view.addSubview(emailTextField)
    emailTextField.borderStyle = .roundedRect
    emailTextField.placeholder = "電話號碼、用戶名稱或電子郵件"
    emailTextField.keyboardType = .emailAddress
    emailTextField.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalTo(view.snp.top).offset(100)
      
    }
    
    passwordTextField = UITextField()
    passwordTextField.backgroundColor = .systemGray2
    view.addSubview(passwordTextField)
    passwordTextField.borderStyle = .roundedRect
    passwordTextField.placeholder = "密碼"
    passwordTextField.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalTo(emailTextField.snp.bottom).offset(30)
    }
    
    loginButton = UIButton()
    loginButton.backgroundColor = .systemBlue
    view.addSubview(loginButton)
    loginButton.setTitle("登入", for: .normal)
    loginButton.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalTo(passwordTextField.snp.bottom).offset(50)
    }
    
    registerButton = UIButton()
    view.addSubview(registerButton)
    registerButton.setTitle("註冊", for: .normal)
    registerButton.setTitleColor(.black, for: .normal)
    registerButton.snp.makeConstraints { (make) -> Void in
        make.width.height.equalTo(50)
        make.top.equalTo(loginButton.snp.bottom).offset(50)
        make.trailing.equalTo(view.snp.trailing).offset(-50)
    }
    
    
    
    registerButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
//    navigationController?.pushViewController(RegisterNavigationController(), animated: true)
//    present(RegisterNavigationController(), animated: true) {
//        <#code#>
//    }
  }
  
  
  @objc func loginButtonDidTap() {
    navigationController?.pushViewController(RegisterNavigationController(), animated: true)

  }
}

extension AuthViewController: UITextFieldDelegate {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
    
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
}

