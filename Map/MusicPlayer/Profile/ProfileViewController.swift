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
        
        navigationView = UIView()
        navigationView.backgroundColor = .systemGray
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
            m.centerX.equalTo(navigationView)
            m.centerY.equalTo(navigationView).offset(30)
            m.height.width.equalTo(120)
        }
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorColor = .systemGray3
        // separatorColor為tableView 底線的顏色
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(navigationView.snp.bottom)
            m.bottom.right.left.equalToSuperview()
        }
        
        signOutButton = UIButton()
        view.addSubview(signOutButton)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.black, for: .normal)
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
            let authViewController = AuthViewController()
            user.isAdmin = false
            authViewController.profileViewController = self
            
            let authNavigationController =  UINavigationController(rootViewController: authViewController)
            authNavigationController.isModalInPresentation = true
            self.present(authNavigationController, animated: true, completion: nil)
            
        } catch {
            self.view.makeToast("無法登出")
        }
        
    }
    
    func updateAPI() {
        let text = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        let url = URL(string: text)
        if let url = url {
            
            //            HUD.shared.showLoading(view: view)
            let hud = JGProgressHUD()
            hud.indicatorView = JGProgressHUDPieIndicatorView()
            hud.progress = 0
            hud.show(in: self.view)
            var currentCount: CGFloat = 0
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    if let json = json ,
                        let xmlHead = json["XML_Head"] as? [String:Any],
                        let infos = xmlHead["Infos"] as? [String:Any] ,
                        let info = infos["Info"] as? [Any] {
                        
                        for i in 0...9 {
                            if let dictionary = info[i] as? [String: Any] {
                                let progressIndex = currentCount / CGFloat(info.count)
                                currentCount += 1.0
                                DispatchQueue.main.async {
                                    hud.setProgress(Float(progressIndex) * 50, animated: true)
                                    hud.textLabel.text = "更新中"
                                    hud.detailTextLabel.text = String(format: "%.2f", progressIndex) + "%"
                                }
                                
                                let spot = Spot(dictionary: dictionary as! [String : Any])
                                let dictionary = spot.dictionary()
                                //                                print("dict: \(dictionary)")
                                Firestore.firestore().collection("Spots").document(spot.id).setData(dictionary) { (error) in
                                    if let error = error {
                                        self.view.makeToast(error.localizedDescription)
                                        print("失敗上傳 :\(error.localizedDescription)")
                                        return
                                    }
                                    self.view.makeToast("成功上傳API")
                                    print("成功上傳: \(spot.id)")
                                }
                            }
                            
                        }
                    }
                    
                }
                HUD.shared.hideLoading()
                
            }.resume()
            
        }
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
        if user.isAdmin {
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
        default:
            cell.textLabel?.text = "您好，歡迎光臨"
        }
        if user.isAdmin && indexPath.row == 5 {
            cell.textLabel?.text = "更新資料庫"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 2:
            let favoriteSpotsViewController = FavoriteSpotsViewController()
            navigationController?.pushViewController(favoriteSpotsViewController, animated: true)
        case 5:
            if user.isAdmin {
                self.updateAPI()
            }
        default:
            break
        }
        
    }
    
    
}
