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
        self.accessoryView = self.customAccessoryView
    }
    
    func setupApiView() {
        self.customAccessoryTextField = UITextField()
        self.customAccessoryTextField.backgroundColor = .white
        self.customAccessoryTextField.keyboardType = .numberPad
        self.customAccessoryTextField.placeholder = "請輸入數量"
        self.customAccessoryTextField.addTarget(self, action: #selector(customAccessoryTextFieldDidBegin), for: .editingDidBegin)
        self.customAccessoryView.addSubview(customAccessoryTextField)
        self.customAccessoryTextField.snp.makeConstraints { (m) in
            m.height.equalToSuperview()
            m.width.equalTo(100)
            m.centerX.equalToSuperview().offset(20)
        }
        self.ApiButton = UIButton()
        self.customAccessoryView.addSubview(ApiButton)
        let image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysOriginal)
        // 調整原生圖片 顏色
        self.ApiButton.setImage(image, for: .normal)
        self.ApiButton.addTarget(self, action: #selector(apiButtonDidTap), for: .touchUpInside)
        self.ApiButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(30)
            m.right.equalToSuperview()
            m.centerY.equalToSuperview()
        }

    }
    
    func setupAcceoryView() {
        self.customAccessoryView = UIView()
        self.customAccessoryView.frame = CGRect(x: 0, y: 0, width: 200, height: frame.height)
           
    }
    
    func setupCustomAccessoryText(text: String) {
        self.customAccessoryLabel = UILabel()
        self.customAccessoryLabel.text = ""
        self.customAccessoryLabel.text = text
        self.customAccessoryView.addSubview(customAccessoryLabel)
        self.customAccessoryLabel.textAlignment = .center
        self.customAccessoryLabel.snp.makeConstraints { (m) in
            m.margins.equalToSuperview()
        }
    }
    
    @objc func apiButtonDidTap() {
        if let text = customAccessoryTextField.text {
            if let count = Int(text) {
                self.delegate.apiButtonDidTap(count: count)
            }
        }
        
    }
    
    @ objc func customAccessoryTextFieldDidBegin() {
        self.delegate.customAccessoryTextFieldDidBegin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
