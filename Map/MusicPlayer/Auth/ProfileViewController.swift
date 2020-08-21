//
//  ProfileViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/18.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var emailLabel: UILabel!
    var nameLabel: UILabel!
    var signOutButton: UIButton!
    var profileImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        view.backgroundColor = .red
        
        
        
        if let user = Auth.auth().currentUser {
            emailLabel.text = user.email
        }
        
  
        
    }
    
    func configureLayout() {
        
        profileImageButton = UIButton()
        view.addSubview(profileImageButton)
        profileImageButton.backgroundColor = .white
        profileImageButton.snp.makeConstraints { (m) in
            m.width.height.equalTo(50)
            m.left.equalToSuperview().offset(20)
            m.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        profileImageButton.addTarget(self, action: #selector(profileImageButtonDidTap), for: .touchUpInside)
        
        
        
          emailLabel = UILabel()
          view.addSubview(emailLabel)
          emailLabel.text = "test@email.com"
          emailLabel.snp.makeConstraints { (m)  in
            m.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
              m.centerX.equalToSuperview()
          }
          
          nameLabel = UILabel()
          view.addSubview(nameLabel)
          nameLabel.text = "Name"
          nameLabel.snp.makeConstraints { (m) in
              m.top.equalTo(emailLabel.snp.bottom).offset(20)
              m.centerX.equalToSuperview()
          }
        signOutButton = UIButton()
        view.addSubview(signOutButton)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        signOutButton.snp.makeConstraints { (m) in
            m.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            m.centerX.equalToSuperview()
        }
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            self.view.makeToast("成功登出")
            let authNavigationController = UINavigationController(rootViewController: AuthViewController())
            authNavigationController.isModalInPresentation = true
            self.present(authNavigationController, animated: true, completion: nil)
            
        } catch {
            self.view.makeToast("無法登出")
        }
        
      }
    @objc func profileImageButtonDidTap() {
        print(1111)
    }
   
}
