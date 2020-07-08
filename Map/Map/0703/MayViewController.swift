//
//  MayViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
class MayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mayLabel = UILabel()
        view.backgroundColor = .lightGray
        mayLabel.textColor = .white
        mayLabel.text = "五月天:倔強"
        view.addSubview(mayLabel)
//        mayLabel.translatesAutoresizingMaskIntoConstraints = false
//        mayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        mayLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        mayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        mayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mayLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }

    }
    

    

}
