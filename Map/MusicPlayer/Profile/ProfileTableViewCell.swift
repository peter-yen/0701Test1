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
    var customAccessoryTextField: UITextField!
    var ApiButton: UIButton!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAcceoryView()
        accessoryView = customAccessoryView
    }
    
    func setupAcceoryView() {
        customAccessoryView = UIView()
        customAccessoryView.frame = CGRect(x: 0, y: 0, width: 200, height: frame.height)
        customAccessoryTextField = UITextField()
        customAccessoryView.addSubview(customAccessoryTextField)
        customAccessoryTextField.backgroundColor = .white
        customAccessoryTextField.keyboardType = .numbersAndPunctuation
        customAccessoryTextField.isEnabled = false
        customAccessoryTextField.snp.makeConstraints { (m) in
            m.height.equalToSuperview()
            m.width.equalTo(100)
            m.centerX.equalToSuperview().offset(20)
        }
        ApiButton = UIButton()
        customAccessoryView.addSubview(ApiButton)
        ApiButton.alpha = 0
        ApiButton.isEnabled = false
        let image = UIImage(named: "return")
        ApiButton.setImage(image, for: .normal)
        ApiButton.addTarget(self, action: #selector(ApiButtonDidTap), for: .touchUpInside)
        ApiButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(30)
            m.right.equalToSuperview()
            m.centerY.equalToSuperview()
        }
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
    
    @objc func ApiButtonDidTap() {
        print("23233")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
