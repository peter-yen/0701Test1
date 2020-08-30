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
    var addLabel: UILabel!
    var townLabel: UILabel!

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        setupBackgroundImage()
        setupLabel()
        
        
    }
    func setupLabel() {
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
        addLabel = UILabel()
        addSubview(addLabel)
        addLabel.text = "Helllo"
        addLabel.textAlignment = .right
        addLabel.textColor = .systemYellow
        addLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(backgroundImageView.snp.bottom).offset(5)
            m.centerX.equalToSuperview()
        }
        townLabel = UILabel()
        addSubview(townLabel)
        townLabel.text = "所在地"
        townLabel.textColor = .cyan
        townLabel.snp.makeConstraints { (m) in
            m.width.equalTo(60)
            m.top.equalTo(addLabel)
            m.left.equalTo(backgroundImageView.snp.left)
        }
        

    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


