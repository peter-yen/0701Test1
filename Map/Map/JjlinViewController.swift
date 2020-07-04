//
//  JjlinViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class JjlinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        let jjlinLabel = UILabel()
        jjlinLabel.text = "林俊傑:他說"
        jjlinLabel.textColor = .systemYellow
        view.addSubview(jjlinLabel)
        jjlinLabel.translatesAutoresizingMaskIntoConstraints = false
        jjlinLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        jjlinLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        jjlinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jjlinLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

       
    }
    

    
}
