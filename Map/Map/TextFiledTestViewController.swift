//
//  TextFiledTestViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/23.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class TextFiledTestViewController: UIViewController {
    var oneTextFiled: UITextField!
    var twoTextFiled: UITextField!
    var oneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        oneTextFiled = UITextField()
        oneTextFiled.backgroundColor = .systemGray2
        view.addSubview(oneTextFiled)
        oneTextFiled.borderStyle = .roundedRect
        oneTextFiled.placeholder = "電話號碼、用戶名稱或電子郵件"
//        oneTextFiled.keyboardType = .emailAddress
        oneTextFiled.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(70)
            
        }
        twoTextFiled = UITextField()
        twoTextFiled.backgroundColor = .systemGray2
        view.addSubview(twoTextFiled)
        twoTextFiled.borderStyle = .roundedRect
        twoTextFiled.placeholder = "密碼"
        twoTextFiled.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(oneTextFiled.snp.bottom).offset(30)
        }
        oneButton = UIButton()
        oneButton.backgroundColor = .systemBlue
        view.addSubview(oneButton)
        oneButton.setTitle("登入", for: .normal)
        oneButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(twoTextFiled.snp.bottom).offset(50)
        }
        
    }
    

  

}
