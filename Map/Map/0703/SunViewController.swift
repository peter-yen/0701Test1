//
//  SunViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SunViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        let sunLabel = UILabel()
        sunLabel.text = "孫燕姿:遇見"
        sunLabel.textColor = .red
        view.addSubview(sunLabel)
//        sunLabel.translatesAutoresizingMaskIntoConstraints = false
//        sunLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        sunLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        sunLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        sunLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sunLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

    }
    

}
