//
//  EasonViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class EasonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        let easonLabel = UILabel()
        easonLabel.text = "陳奕迅:十年"
        easonLabel.textColor = .brown
        view.addSubview(easonLabel)
        easonLabel.translatesAutoresizingMaskIntoConstraints = false
        easonLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        easonLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        easonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        easonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    

    

}
