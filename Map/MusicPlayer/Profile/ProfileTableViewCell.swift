//
//  ProfileTableViewCell.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

protocol ProfileTableViewCellDelegate {
    func apiButtonDidTap(count: Int)
    func customAccessoryTextFieldDidBegin()
}

class ProfileTableViewCell: UITableViewCell {
    private var customAccessoryLabel: UILabel!
    private var customAccessoryView: UIView!
    var customAccessoryTextField: UITextField!
    var ApiButton: UIButton!
    var delegate: ProfileTableViewCellDelegate!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAcceoryView()
        accessoryView = customAccessoryView
    }
    
    func setupApiView() {
        customAccessoryTextField = UITextField()
        customAccessoryTextField.backgroundColor = .white
        customAccessoryTextField.keyboardType = .numberPad
        customAccessoryTextField.placeholder = "請輸入數量"
        customAccessoryTextField.addTarget(self, action: #selector(customAccessoryTextFieldDidBegin), for: .editingDidBegin)
        customAccessoryView.addSubview(customAccessoryTextField)
        customAccessoryTextField.snp.makeConstraints { (m) in
            m.height.equalToSuperview()
            m.width.equalTo(100)
            m.centerX.equalToSuperview().offset(20)
        }
        ApiButton = UIButton()
        customAccessoryView.addSubview(ApiButton)
        let image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysOriginal)
        ApiButton.setImage(image, for: .normal)
        ApiButton.addTarget(self, action: #selector(apiButtonDidTap), for: .touchUpInside)
        ApiButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(30)
            m.right.equalToSuperview()
            m.centerY.equalToSuperview()
        }

    }
    
    func setupAcceoryView() {
        customAccessoryView = UIView()
        customAccessoryView.frame = CGRect(x: 0, y: 0, width: 200, height: frame.height)
           
    }
    
    func setupCustomAccessoryText(text: String) {
        customAccessoryLabel = UILabel()
        customAccessoryLabel.text = ""
        customAccessoryLabel.text = text
        customAccessoryView.addSubview(customAccessoryLabel)
        customAccessoryLabel.textAlignment = .center
        customAccessoryLabel.snp.makeConstraints { (m) in
            m.margins.equalToSuperview()
        }
    }
    
    @objc func apiButtonDidTap() {
        if let text = customAccessoryTextField.text {
            if let count = Int(text) {
                delegate.apiButtonDidTap(count: count)
            }
        }
        
    }
    
    @ objc func customAccessoryTextFieldDidBegin() {
        delegate.customAccessoryTextFieldDidBegin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
