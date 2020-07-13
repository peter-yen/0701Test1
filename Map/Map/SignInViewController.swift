//
//  SignInViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/11.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class SignInViewController: UIViewController {
    var googleSignInButton: GIDSignInButton!
    var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        view.backgroundColor = .white
        
        setupSignInButton()
        setupEmailLabel()
    }
    func setupSignInButton() {
        googleSignInButton = GIDSignInButton()
        googleSignInButton.backgroundColor = .red
        googleSignInButton.addTarget(self, action: #selector(googleSignUpDidTap), for: .touchUpInside)
        view.addSubview(googleSignInButton)
        googleSignInButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }
    @objc func googleSignUpDidTap() {
        print(1111)
        emailLabel.text = "test1@email"
    }
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "sss@email.com"
        view.addSubview(emailLabel)
        emailLabel.backgroundColor = .red
        emailLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(googleSignInButton.snp.top).offset(-30)
            make.centerX.equalToSuperview()
        }
    }

  

}
