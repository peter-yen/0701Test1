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
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    var navigationView: UIView!
    var tableView: UITableView!
    var avatarImageView: UIImageView!
    var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        view.backgroundColor = .red
    
    }
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
//            emailLabel.text = user.email
        }
        
    }
          
    
    func configureLayout() {
        
        navigationView = UIView()
        navigationView.backgroundColor = .green
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.height.equalTo(250)
        }
        avatarImageView = UIImageView()
        view.addSubview(avatarImageView)
        avatarImageView.image = UIImage(named: "Hebe")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarImageViewDidTap))
        avatarImageView.addGestureRecognizer(tap)
        avatarImageView.snp.makeConstraints { (m) in
            m.centerX.centerY.equalTo(navigationView)
            m.height.width.equalTo(120)
        }
        
        tableView = UITableView()
        tableView.backgroundColor = .blue
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(navigationView.snp.bottom)
            m.bottom.right.left.equalToSuperview()
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
    @objc func avatarImageViewDidTap() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
        
        
        
        
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            self.view.makeToast("成功登出")
            let authNavigationController = UINavigationController(rootViewController: AuthViewController())
            authNavigationController.modalPresentationStyle = .fullScreen
//            authNavigationController.isModalInPresentation = true
            self.present(authNavigationController, animated: true, completion: nil)
            
        } catch {
            self.view.makeToast("無法登出")
        }
        
      }
    
    
   
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate { //這個是能讀取本地相簿的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.avatarImageView.image = image
        }
        self.dismiss(animated: true, completion: nil )
    }
    
    
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.backgroundColor = .white
        if indexPath.row == 0 {
            cell.textLabel?.text = "Email"
            if let user = Auth.auth().currentUser {
                if let email = user.email {
                    let view = UIView()
                    view.frame = CGRect(x: 0, y: 0, width: 200, height: cell.frame.height) //accessory意思為右邊的意思
                    let label = UILabel()
                    label.text = email
                    view.addSubview(label)
                    label.textAlignment = .center
                    label.snp.makeConstraints { (m) in
                        m.margins.equalToSuperview()
                    }
                    cell.accessoryView = view

                }
            }
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Name"
            if let user = Auth.auth().currentUser {
            if let email = user.email {
                let view = UIView()
                view.frame = CGRect(x: 0, y: 0, width: 200, height: cell.frame.height) //accessory意思為右邊的意思
                let label = UILabel()
                label.text = email
                view.addSubview(label)
                label.textAlignment = .center
                label.snp.makeConstraints { (m) in
                    m.margins.equalToSuperview()
                }
                cell.accessoryView = view
                }
            }
        } else {
            
            cell.textLabel?.text = "sdf"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let uid = Auth.auth().currentUser?.uid { //Get是拿資料，Set是存資料
            Firestore.firestore().collection("Users").document(uid).getDocument { (snapshot, err) in
                if let err = err {
                    self.view.makeToast(err.localizedDescription)
                    return
            }
                if let dictionary = snapshot?.data() {
                    if let email = dictionary["email"] as? String,
                        let name = dictionary["name"] as? String {
                        print("email: \(email),\nname:\(name)")
                    }
                }
            }
        }
        
    }
    
    
}
