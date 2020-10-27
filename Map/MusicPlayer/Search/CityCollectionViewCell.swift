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
    
    var nameLabel: UILabel = {
      let nl = UILabel()
        nl.font = UIFont.systemFont(ofSize: 20)
        nl.textColor = .white
        return nl
    }()
    var backgroundImageView: UIImageView = {
       let bv = UIImageView()
        bv.contentMode = .scaleAspectFill
        bv.clipsToBounds = true
        return bv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        setupBackgroundImage()
        setupLabel()
        
    }
    func setupLabel() {
        addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (m) in
            m.bottom.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func setupBackgroundImage() {
        addSubview(backgroundImageView)
        self.backgroundImageView.image = UIImage(named: "Hebe")
        self.backgroundImageView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
