//
//  TextFiledTestViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/23.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import Toast_Swift


class AuthViewController: UIViewController {
  var emailTextField: UITextField! //emailTextField
  var passwordTextField: UITextField! //passwordTextField
  var loginButton: UIButton! //loginButton
    var registerButton: UIButton!
    var profileViewController: ProfileViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    self.emailTextField = UITextField()
    view.addSubview(emailTextField)
    self.emailTextField.backgroundColor = .systemGray3
    self.emailTextField.delegate = self
    self.emailTextField.borderStyle = .roundedRect
    self.emailTextField.placeholder = "電話號碼、用戶名稱或電子郵件"
    self.emailTextField.keyboardType = .emailAddress
    self.emailTextField.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalTo(view.snp.top).offset(100)
      
    }
    
    self.passwordTextField = UITextField()
    view.addSubview(passwordTextField)
    self.passwordTextField.backgroundColor = .systemGray3
    self.passwordTextField.isSecureTextEntry = true
    self.passwordTextField.borderStyle = .roundedRect
    self.passwordTextField.placeholder = "密碼"
    self.passwordTextField.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalTo(emailTextField.snp.bottom).offset(30)
    }
    
    self.loginButton = UIButton()
    view.addSubview(loginButton)
    self.loginButton.backgroundColor = .systemBlue
    self.loginButton.clipsToBounds = true
    self.loginButton.layer.cornerRadius = 20
    self.loginButton.setTitle("登入", for: .normal)
    self.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    self.loginButton.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalTo(passwordTextField.snp.bottom).offset(50)
    }
    
    self.registerButton = UIButton()
    view.addSubview(registerButton)
    self.registerButton.setTitle("註冊", for: .normal)
    self.registerButton.setTitleColor(.black, for: .normal)
    self.registerButton.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
    self.registerButton.snp.makeConstraints { (make) -> Void in
        make.width.height.equalTo(50)
        make.top.equalTo(loginButton.snp.bottom).offset(50)
        make.trailing.equalTo(view.snp.trailing).offset(-50)
    }
  }
    
    @objc func loginButtonDidTap() {
        if let email = self.emailTextField.text,
           let password = self.passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let err = error {
                    self.view.makeToast(err.localizedDescription)
                }else {
                    self.view.makeToast("登入成功")
                    self.profileViewController?.setupData()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }

    }
  
  @objc func registerButtonDidTap() {
    let stepOneViewController = StepOneViewController()
    navigationController?.pushViewController(stepOneViewController, animated: true)
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

