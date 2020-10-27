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
import FirebaseStorage
import JGProgressHUD
import SDWebImage

class ProfileViewController: UIViewController {
    
    var navigationView: UIView!
    var tableView: UITableView!
    var avatarImageView: UIImageView!
    var signOutButton: UIButton!
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        
        view.backgroundColor = .white
        setupData()
        user = User(email: "", name: "", password: "")
        
        title = "個人資料"
        
        // 點擊要打字的行列時 , 鍵盤擋住的話 , view會往上移
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setupData() {
        HUD.shared.showLoading(view: view)
        if let uid = Auth.auth().currentUser?.uid {
            
            /*
             同步 sync: 發出A請求 -> 收到A回應 -> 才能發出B請求  就是一個跑完才能跑下一個（照著流程）
             非同步 async: 發出A請求 -> 發出B請求 -> 收到 A or B 回應 （誰做好誰先回來，不需要等）
             Client: 客戶端， ex:網頁、手機
             Server: 伺服器， ex:Firestore , Database , https
             https請求類型： Get , Post , Delete , Put ...
             https回應種類： 404, 400 , 200 ...
             有 completion block(閉包) 的方法通常為非同步請求
             */
            
            API.shared.userRef(uid: uid).getDocument { (snapshot, err) in
                if let err = err {
                    self.view.makeToast(err.localizedDescription)
                    return
                }
                if let dictionary = snapshot?.data() {
                    
                    if let name = dictionary["name"] as? String,
                       let email = dictionary["email"] as? String {
                        self.user.name = name
                        self.user.email = email
                        if let isAdmin = dictionary["isAdmin"] as? Bool {
                            self.user.isAdmin = isAdmin
                        }
                        self.tableView.reloadData()
                    }
                    
                    if let profileImageURL = dictionary["profileImageURL"] as? String {
                        
                        self.avatarImageView.sd_setImage(with: URL(string: profileImageURL)) { (_, _, _, _) in
                            HUD.shared.hideLoading()
                        }
                        
                    } else {
                        HUD.shared.hideLoading()
                        
                    }
                }
            }
        }
    }
    
    func configureLayout() {
        
        self.navigationView = UIView()
        self.navigationView.backgroundColor = .systemGray
        view.addSubview(navigationView)
        self.navigationView.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.height.equalTo(250)
        }
        self.avatarImageView = UIImageView()
        view.addSubview(avatarImageView)
        self.avatarImageView.image = UIImage(named: "Hebe")
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.layer.cornerRadius = 60
        self.avatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarImageViewDidTap))
        self.avatarImageView.addGestureRecognizer(tap)
        self.avatarImageView.snp.makeConstraints { (m) in
            m.centerX.equalTo(navigationView)
            m.centerY.equalTo(navigationView).offset(30)
            m.height.width.equalTo(120)
        }
        
        self.tableView = UITableView()
        view.addSubview(tableView)
        self.tableView.backgroundColor = .white
        self.tableView.separatorColor = .systemGray3
        // separatorColor為tableView 底線的顏色
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.snp.makeConstraints { (m) in
            m.top.equalTo(navigationView.snp.bottom)
            m.bottom.right.left.equalToSuperview()
        }
        
        self.signOutButton = UIButton()
        view.addSubview(signOutButton)
        self.signOutButton.setTitle("Sign Out", for: .normal)
        self.signOutButton.setTitleColor(.black, for: .normal)
        self.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        self.signOutButton.snp.makeConstraints { (m) in
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
            let authViewController = AuthViewController()
            self.user.isAdmin = false
            authViewController.profileViewController = self
            
            let authNavigationController =  UINavigationController(rootViewController: authViewController)
            authNavigationController.isModalInPresentation = true
            self.present(authNavigationController, animated: true, completion: nil)
            
        } catch {
            self.view.makeToast("無法登出")
        }
        
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = .zero
    }
    
    
    
    
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate { //這個是能讀取本地相簿的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.avatarImageView.image = image
            saveToStorage(image: image)
        }
        self.dismiss(animated: true, completion: nil )
    }
     
    
    func saveToStorage(image: UIImage) {
        if let uid = Auth.auth().currentUser?.uid {
            // Storage 路徑
            let ref = Storage.storage().reference(withPath: "users/\(uid)/")
            // image -> Data
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                ref.putData(imageData, metadata: nil) { (metadata, err) in
                    if let err = err {
                        self.view.makeToast(err.localizedDescription)
                        return
                    }
                    // 取得url
                    ref.downloadURL { (url, err) in
                        if let err = err {
                            self.view.makeToast(err.localizedDescription)
                            return
                        }
                        print("image url: \(url)")  //url轉換成String
                        if let urlString = url?.absoluteString {
                            let dictionary = ["profileImageURL": urlString]
                            API.shared.userRef(uid: uid).updateData(dictionary) { (err) in
                                if let err = err {
                                    self.view.makeToast(err.localizedDescription)
                                    return
                                } // document 文件 collection
                                self.view.makeToast("成功上傳圖片")
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.user.isAdmin {
            return 6
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProfileTableViewCell
        cell.backgroundColor = .white
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Email"
            cell.setupCustomAccessoryText(text: user.email)
        case 1:
            cell.textLabel?.text = "Name"
            cell.setupCustomAccessoryText(text: user.name)
        case 2:
            cell.textLabel?.text = "我的收藏"
            cell.accessoryView = nil // accessory 屬性只能存在一個
            cell.accessoryType = .disclosureIndicator
        case 5:
            if self.user.isAdmin {
                cell.textLabel?.text = "更新資料庫"
                cell.delegate = self
                cell.setupApiView()
                cell.customAccessoryTextField.delegate = self
            }
        default:
            cell.textLabel?.text = "您好，歡迎光臨"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 2:
            let favoriteSpotsViewController = FavoriteSpotsViewController()
            navigationController?.pushViewController(favoriteSpotsViewController, animated: true)
        default:
            break
        }
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
        
    }
    
}


extension ProfileViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension ProfileViewController: ProfileTableViewCellDelegate {
    func customAccessoryTextFieldDidBegin() {
        print("4343434")
        
    }
    
    func apiButtonDidTap(count: Int) {
        if user.isAdmin {
            API.shared.removeSpots {
                API.shared.removeCities {
                    API.shared.updataSpotsAPI(count: count) {
                        print("成功上傳")
                    }
                }
            }
        }
        
    }
    
    
}
