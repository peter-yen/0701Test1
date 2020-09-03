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
            favoriteButton.isSelected = spotViewController.favoriteSpotsIDs.firstIndex(of: spot.id) != nil
                  
                    
            //        if favoriteSpotsIDs.firstIndex(of: spot.id) != nil {
            //            cell.favoriteButton.isSelected = true
            //        } else {
            //            cell.favoriteButton.isSelected = false
            //        }
        }
    }
    var nameLabel: UILabel!
    var backgroundImageView: UIImageView!
    var addressLabel: UILabel!
    var townLabel: UILabel!
    var favoriteButton: UIButton!
    var spotViewController: SpotsViewController!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupBackgroundImage()
        setupNameLabel()
        setupTownLabel()
        setupAdressLabel()
        setupFavoriteButton()
        
        
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        nameLabel.text = "城市"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .red
        nameLabel.snp.makeConstraints { (m) in
            m.left.equalTo(backgroundImageView)
            m.top.equalTo(backgroundImageView.snp.bottom)
        }
        
        
    }
    
    func setupBackgroundImage() {
        backgroundImageView = UIImageView()
        addSubview(backgroundImageView)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.backgroundColor = .systemBlue
        backgroundImageView.image = UIImage(named: "Hebe")
        backgroundImageView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
            
        }
    }
    func setupAdressLabel() {
        addressLabel = UILabel()
        addSubview(addressLabel)
        addressLabel.text = "Helllo"
        addressLabel.textAlignment = .right
        addressLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addressLabel.textColor = .black
        addressLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(townLabel)
            m.centerX.equalToSuperview()
        }
        
    }
    func setupTownLabel() {
        townLabel = UILabel()
        addSubview(townLabel)
        townLabel.text = "所在地"
        townLabel.font = UIFont.boldSystemFont(ofSize: 15)
        townLabel.textColor = .black
        townLabel.snp.makeConstraints { (m) in
            m.width.equalTo(60)
            m.top.equalTo(nameLabel.snp.bottom).offset(6)
            m.left.equalTo(backgroundImageView.snp.left)
        }
        
    }
    
    func setupFavoriteButton() {
        favoriteButton = UIButton()
        addSubview(favoriteButton)
        
        let selectedImage = UIImage(named: "favorite_selected")
        let unselectedImage = UIImage(named: "favorite_unselected")
        favoriteButton.setImage(selectedImage, for: .selected)
        favoriteButton.setImage(unselectedImage, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)
        
        favoriteButton.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(5)
            m.trailing.equalToSuperview().offset(-5)
            m.width.height.equalTo(40)
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
                                
                                self.spotViewController.favoriteSpotsIDs = newFavoriteArray
                                
                                data = ["favoriteSpots": newFavoriteArray]
                            }
                            
                        } else {
                            // FireStore 沒有這個 Dictionary 的話直接創建一個
                            let newFavoriteArray = [self.spot.id]
                            
                            self.spotViewController.favoriteSpotsIDs = newFavoriteArray
                            
                            data = ["favoriteSpots": newFavoriteArray]
                        }
                        
                         API.shared.userRef(uid: uid).updateData(data) { (err) in
                            if let err = err {
                                self.makeToast(err.localizedDescription)
                            } else {
                                self.makeToast("成功上傳！！！")
                            }
                        }
                    }
                }
            }
            
        } else {
            // 已點選 -> 還沒點選
            favoriteButton.isSelected = false
            
            if let uid = Auth.auth().currentUser?.uid {
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
                                
                                self.spotViewController.favoriteSpotsIDs = newFavoriteArray
                                
                                let data = ["favoriteSpots": newFavoriteArray]
                                
                                 API.shared.userRef(uid: uid).updateData(data) { (err) in
                                    if let err = err {
                                        self.makeToast(err.localizedDescription)
                                        
                                    } else {
                                        self.makeToast("成功刪除！！！")
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    // 1. 存入（updetedata） User 中 favoriteSpots [陣列] 中
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
