//
//  ProfileTableViewCell.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    private var customAccessoryLabel: UILabel!
    private var customAccessoryView: UIView!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAcceoryView()
        accessoryView = customAccessoryView
    }
    
    func setupAcceoryView() {
    customAccessoryView = UIView()
    customAccessoryView.frame = CGRect(x: 0, y: 0, width: 200, height: frame.height)
    customAccessoryLabel = UILabel()
    customAccessoryLabel.text = ""
    customAccessoryView.addSubview(customAccessoryLabel)
    customAccessoryLabel.textAlignment = .center
    customAccessoryLabel.snp.makeConstraints { (m) in
    m.margins.equalToSuperview()
    }
    
    }
    func setupCustomAccessoryText(text: String) {
        customAccessoryLabel.text = text
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
