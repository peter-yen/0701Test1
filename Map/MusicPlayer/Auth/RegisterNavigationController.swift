//
//  RegisterViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/5.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import Toast_Swift
import FirebaseFirestore

class RegisterNavigationController: UIViewController {
    var nameTextfield: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.makeToast("HEllO")
        
        nameTextfield = UITextField()
        view.addSubview(nameTextfield)
        nameTextfield.backgroundColor = .systemGray2
        nameTextfield.borderStyle = .roundedRect
        nameTextfield.placeholder = "暱稱"
        nameTextfield.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(100)
            
        }
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        emailTextField.backgroundColor = .systemGray2
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "電子郵件"
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextfield.snp.bottom).offset(30)
            
        }
        
        passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .systemGray2
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "密碼"
        passwordTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            
        }
        
        registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitle("註冊", for: .normal)
        registerButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
        }
        
        registerButton.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
        

        
    }
    
    @objc func registerButtonDidTap() {
        
        if let name = nameTextfield.text ,
            let email = emailTextField.text ,
            let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                print("result: \(result), error: \(error)")
                if let error = error {
                    self.view.makeToast(error.localizedDescription)
                } else {
                    
                    let dictionary: [String:Any] = ["email": email,
                                                    "password": password,
                                                    "name": name]
                    if let uid = Auth.auth().currentUser?.uid {
                        Firestore.firestore().collection("Users").document(uid).setData(dictionary) { (error) in
                            print("error: \(error)")
                            self.view.makeToast("Succes")
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
                
            }
        }

        print(11111)

    }
    
    

    

}
extension RegisterNavigationController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
