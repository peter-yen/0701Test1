//
//  CityCollectionViewCell.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class CityCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var backgroundImageView: UIImageView!
    
    
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
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
