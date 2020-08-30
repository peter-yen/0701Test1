//
//  SpotCollectionViewCell.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class SpotCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var backgroundImageView: UIImageView!
    var addressLabel: UILabel!
    var townLabel: UILabel!
    var favoriteButton: UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        setupBackgroundImage()
        setupNameLabel()
        setupAdressLabel()
        setupTownLabel()
        setupFavoriteButton()
        
        
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        nameLabel.text = "城市"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { (m) in
            m.bottom.trailing.equalToSuperview().offset(-5)
        }
        
        
    }
    
    func setupBackgroundImage() {
        backgroundImageView = UIImageView()
        addSubview(backgroundImageView)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
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
        addressLabel.textColor = .systemYellow
        addressLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(backgroundImageView.snp.bottom).offset(5)
            m.centerX.equalToSuperview()
        }
        
    }
    func setupTownLabel() {
        townLabel = UILabel()
        addSubview(townLabel)
        townLabel.text = "所在地"
        townLabel.textColor = .cyan
        townLabel.snp.makeConstraints { (m) in
            m.width.equalTo(60)
            m.top.equalTo(addressLabel)
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
        favoriteButton.isSelected = !favoriteButton.isSelected
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


