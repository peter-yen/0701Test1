//
//  SpotCollectionViewCell.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Toast_Swift

class SpotCollectionViewCell: UICollectionViewCell {
    
    var spot: Spot! {
        didSet {
            let url = URL(string: spot.picture1)
            backgroundImageView.sd_setImage(with: url, completed: nil)
            nameLabel.text = spot.name
            addressLabel.text = spot.address
            townLabel.text = spot.district
            
            if spotViewController != nil {
                favoriteButton.isSelected = spotViewController?.favoriteSpotsIDs.firstIndex(of: spot.id) != nil
            } else if favoriteSpotsViewCOntroller != nil {
                favoriteButton.isSelected = true
            }
            //        if favoriteSpotsIDs.firstIndex(of: spot.id) != nil {
            //            cell.favoriteButton.isSelected = true
            //        } else {
            //            cell.favoriteButton.isSelected = false
            //        }
            // SpotViewController 的 cellForItem 裡的東西，本來就是 cell 的
            // 所以拿回 cell 做 ， 版面看起來會比較乾淨
        }
    }
    lazy var nameLabel: UILabel = {
       let nl = UILabel()
        nl.font = UIFont.boldSystemFont(ofSize: 18)
        nl.textColor = .red
        return nl
    }()
    lazy var backgroundImageView: UIImageView = {
        let bi = UIImageView()
        bi.contentMode = .scaleAspectFill
        bi.clipsToBounds = true
        bi.backgroundColor = .systemBlue
        return bi
    }()
    lazy var addressLabel: UILabel = {
       let al = UILabel()
        al.textAlignment = .right
        al.font = UIFont.boldSystemFont(ofSize: 15)
        al.textColor = .black
        return al
    }()
    lazy var townLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.boldSystemFont(ofSize: 15)
        tl.textColor = .black
        return tl
    }()
    var favoriteButton: UIButton!
    var spotViewController: SpotsViewController?
    var favoriteSpotsViewCOntroller: FavoriteSpotsViewController?
    var spotsCollectionViewController: SpotsCollectionViewController?
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupImageView()
        setupSubviews()
        setupFavoriteButton()
        
    }
    
    func setupImageView() {
        addSubview(backgroundImageView)
        self.backgroundImageView.image = UIImage(named: "Hebe")
        self.backgroundImageView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }

    }
    
    func setupSubviews() {
        addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (m) in
            m.left.equalTo(backgroundImageView)
            m.top.equalTo(backgroundImageView.snp.bottom)
        }
        addSubview(townLabel)
        self.townLabel.snp.makeConstraints { (m) in
            m.width.equalTo(60)
            m.top.equalTo(nameLabel.snp.bottom).offset(6)
            m.left.equalTo(backgroundImageView.snp.left)
        }
        addSubview(addressLabel)
        self.addressLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(townLabel)
            m.centerX.equalToSuperview()
        }
    }
        
    
    
    func setupFavoriteButton() {
        self.favoriteButton = UIButton()
        addSubview(favoriteButton)
        
        let selectedImage = UIImage(named: "favorite_selected")
        let unselectedImage = UIImage(named: "favorite_unselected")
        self.favoriteButton.setImage(selectedImage, for: .selected)
        self.favoriteButton.setImage(unselectedImage, for: .normal)
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)
        
        self.favoriteButton.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(5)
            m.trailing.equalToSuperview().offset(-5)
            m.width.height.equalTo(35)
        }
    }
    
    
    @objc func favoriteButtonDidTap() {
        
        if !favoriteButton.isSelected {
            // 還沒點選 -> 已點選
            favoriteButton.isSelected = true
            
            if let uid = Auth.auth().currentUser?.uid {
                API.shared.userRef(uid: uid).getDocument { (snapshot, error) in
                    if let error = error {
                        self.makeToast(error.localizedDescription)
                        return
                    }
                    
                    if let dictionary = snapshot?.data() {
                        
                        var data: [String: Any] = [:]
                        
                        if let favoriteArray = dictionary["favoriteSpots"] as? [String] {
                            
                            var newFavoriteArray = favoriteArray
                            
                            if newFavoriteArray.firstIndex(of: self.spot.id) == nil {
                                newFavoriteArray.append(self.spot.id)
                                
                                self.spotsCollectionViewController?.favoriteSpotsIDs = newFavoriteArray
                                
                                
                                data = ["favoriteSpots": newFavoriteArray]
                            }
                            
                        } else {
                            // FireStore 沒有這個 Dictionary 的話直接創建一個
                            let newFavoriteArray = [self.spot.id]
                            
                            self.spotsCollectionViewController?.favoriteSpotsIDs = newFavoriteArray
                            
                            data = ["favoriteSpots": newFavoriteArray]
                        }
                        
                        API.shared.userRef(uid: uid).updateData(data) { (err) in
                            if let err = err {
                                self.makeToast(err.localizedDescription)
                            } else {
                                self.spotsCollectionViewController?.view.makeToast("成功上傳！！！")
                            }
                        }
                    }
                }
            }
            
        } else {
            // 已點選 -> 還沒點選
            
            favoriteButton.isSelected = false
            
            if spotsCollectionViewController != nil {
                
                if let uid = Auth.auth().currentUser?.uid {
                    
                    HUD.shared.showLoading(view: self.spotsCollectionViewController!.view)
                    
                    API.shared.userRef(uid: uid).getDocument { (snapshot, error) in
                        if let error = error {
                            self.makeToast(error.localizedDescription)
                            return
                        }
                        
                        if let dictionary = snapshot?.data() {
                            
                            if let favoriteArray = dictionary["favoriteSpots"] as? [String] {
                                
                                if let index = favoriteArray.firstIndex(of: self.spot.id) {
                                    
                                    var newFavoriteArray = favoriteArray
                                    
                                    newFavoriteArray.remove(at: index)
                                    
                                    self.spotsCollectionViewController?.favoriteSpotsIDs = newFavoriteArray
                                    
                                    let data = ["favoriteSpots": newFavoriteArray]
                                    
                                    API.shared.userRef(uid: uid).updateData(data) { (err) in
                                        if let err = err {
                                            self.spotsCollectionViewController?.view.makeToast(err.localizedDescription)
                                            
                                        } else {
                                            self.spotsCollectionViewController?.view.makeToast("成功刪除！！！")
                                            HUD.shared.hideLoading()
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
            } else if favoriteSpotsViewCOntroller != nil {
                
                
                if let uid = Auth.auth().currentUser?.uid {
                    
                    HUD.shared.showLoading(view: favoriteSpotsViewCOntroller!.view)
                    
                    API.shared.userRef(uid: uid).getDocument { (snapshot, error) in
                        if let error = error {
                            self.makeToast(error.localizedDescription)
                            return
                        }
                        
                        if let dictionary = snapshot?.data() {
                            
                            if let favoriteArray = dictionary["favoriteSpots"] as? [String] {
                                
                                if let index = favoriteArray.firstIndex(of: self.spot.id) {
                                    
                                    var newFavoriteArray = favoriteArray
                                    
                                    newFavoriteArray.remove(at: index)
                                    
                                    self.favoriteSpotsViewCOntroller?.favoriteSpotsIDs = newFavoriteArray
                                    
                                    let data = ["favoriteSpots": newFavoriteArray]
                                    
                                    API.shared.userRef(uid: uid).updateData(data) { (err) in
                                        if let err = err {
                                            self.favoriteSpotsViewCOntroller?.view.makeToast(err.localizedDescription)
                                            
                                        } else {
                                            
                                            self.favoriteSpotsViewCOntroller?.favoriteSpotsIDs = newFavoriteArray
                                            if let index = self.favoriteSpotsViewCOntroller?.favoriteSpots.firstIndex(of: self.spot) {
                                                self.favoriteSpotsViewCOntroller?.favoriteSpots.remove(at: index)
                                            }// 上面的 else 不是已經重複動作了嗎？
                                
                                            
                                            self.favoriteSpotsViewCOntroller?.view.makeToast("成功刪除！！！")
                                        }
                                        
                                        
                                        DispatchQueue.main.async {
                                            self.favoriteSpotsViewCOntroller?.collectionView.reloadData()
                                            HUD.shared.hideLoading()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
