//
//  SunViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class SunViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        let sunLabel = UILabel()
        sunLabel.text = "孫燕姿:遇見"
        sunLabel.textColor = .red
        view.addSubview(sunLabel)
        sunLabel.translatesAutoresizingMaskIntoConstraints = false
        sunLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sunLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        sunLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sunLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    

}
