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
        HUD.shared.showLoading(view: view)
        // 拿到 getTaiwnSpots 封包 解析 json 數量 [100] 個資列
        getTaiwanSpots(url: "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json", count: 100) { (spots) in
            
            // 不懂 好不容易在 updateSpots 做好 return cityEnumDict
            // 這裏又馬上說他 ＝ slef.updsteSpots(spots: spots)
            if let cityEnumDict = self.updateSpots(spots: spots) {
                // 做一個 把 (key, values) 丟進去 cityEunmDict 的迴圈
                for (key, values) in cityEnumDict {
                    
                    let data = ["cityIds": values]
                    // 更新創建 資料 key.ralValue 就是 cityEnum的ralVaiue
                    // data 其實就是 比如 ["台東市": value 就是符合台東市的 [spot.id] 陣列
                    Firestore.firestore().collection("Cities").document(key.rawValue).setData(data) { (err) in
                        if let err = err {
                            print(err)
                            return
                                HUD.shared.hideLoading()
                        }
                    }
                }
            }
            
        }
        
    }
    
    func updateSpots (spots: [Spot]) -> [CityEnum: [String]]? {
        var cityEnumDict : [CityEnum: [String]] = [:]
        // 這個包好多層有點...
        
        for spot in spots {
            // 把 spot 這個物件 加進去 spots 裡面做迴圈
            if let city = spot.city, let cityEnum = CityEnum.init(rawValue: city) {
                // 把從 spot.city 拿到資料的 city 加進去 CityEnum ralValue 裡
                // 拉進去 enum 的用意為： 他會幫你偵測你是屬於哪個 value， 類似說
                // 如果我 city 是"台東縣"的話 他就等於是 TTH , 因為 TTH 的 value 是 "台東縣"
                
                // 確定 City 目錄底下有這個 Spot
                Firestore.firestore().collection("Spots").document(spot.id).setData(spot.dictionary()) { (err) in
                    // 重新 創建  spot.dictionary 解析成我 Class Spot 打的樣子
                    // 拿到 spot.id 裡面的 dictionary
                    // 還是不太懂 為何要 setData , setData 不是重建一個資料夾嗎？
                    
                    if let err = err {
                        print(err)
                        return
                    }
                }
                // 假如我 spot.city 有符合 cityEnum 那些縣市名
                // 也就是下面打的 cityEnum != nil (有值的)，
                // 上面創建的 cityenum型別的 dict 會增加 spot.id ,
                // 比如 符合"台東縣"的 ，台東縣的那個 ralvalue 有值 ，
                // 會在"台東縣" 增加 spot.id
                // 沒有的話 ， 我的 cityEnumDict[cityEnum] 會等於 [spot.id] 不太懂
                
                
                if cityEnumDict[cityEnum] != nil {
                    cityEnumDict[cityEnum]!.append(spot.id)
                } else {
                    cityEnumDict[cityEnum] = [spot.id]
                }
            }
        }
        return cityEnumDict
    }
    
    
    
    func getTaiwanSpots(url: String,count: Int, completion: @escaping ([Spot])->Void) {
        
        // 做一個封包 解析呼叫這個封包 給的網址 (String) 解析 json Dictionary
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
            guard let xmlHead = json["XML_Head"] as? [String:Any] else { return }
            
            guard let infos = xmlHead["Infos"] as? [String:Any] else { return }
            guard let info = infos["Info"] as? [[String: Any]] else { return }
            
            
            //  做一個迴圈 , 把 dict 丟進去 info[] 裡
            // 再把他丟到 Class Spot 裡有做好的型別解析轉換，再丟回 spots[] 裡
            // [spots] 裡是 dictionary
            
            var spots: [Spot] = []
            for dict in info[0...count - 1] {
                let spot = Spot(dictionary: dict)
                spots.append(spot)
            }
            completion(spots)
            
        }.resume()
    }
    
    func upLoadFireStore(spots: [Spot], completion: ()->Void) {
        
        //  去 Firestore 拿 Cities 資料夾的資料 , 如果沒有 spot.city 會多創一個 "貓貓市"
        
        for spot in spots {
            Firestore.firestore().collection("Cities").document(spot.city ?? "貓貓市").getDocument { (snapshot, err) in
                
                print("asnyc call: \(spot.city)")
                
                if let data = snapshot?.data() {
                    // 拿到 spot.city Data 的資料
                    if let spotsIds = data["spotsIds"] as? [String] {
                        if spotsIds.firstIndex(of: spot.id) == nil {
                            // 判斷式 假如 SpotsIds[] 是空的
                            // spotsIds 會增加 spot.id
                            var newSpotsIds = spotsIds
                            newSpotsIds.append(spot.id)
                            
                //  在 Firestore  Cities 資料夾 , 去更新每個 spot.city 的 data, "SpotIds" ： 加入 [newSpotsIds]
                       
                            Firestore.firestore().collection("Cities").document(spot.city ?? "貓貓市").updateData(["SpotIds": newSpotsIds]) { (err) in
                                
                                print("upDate", spot)
                            }
                        }
                    } else {
                        // 如果 data 裡面 沒有 spotsIds 的 String 陣列
                        // 會直接創建一個 ["SpotsIds": [spot.id]]
                        Firestore.firestore().collection("Cities").document(spot.city ?? "貓貓市").setData(["spotsIds": [spot.id]]) { (err) in
                            
                        }
                    }
                }
                
            }
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
