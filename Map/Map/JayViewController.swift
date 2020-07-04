//
//  JayViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class JayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let jayLabel = UILabel()
        jayLabel.text = "周杰倫:退後"
        jayLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        jayLabel.textColor = .black
        view.addSubview(jayLabel)
        jayLabel.translatesAutoresizingMaskIntoConstraints = false
        jayLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        jayLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        jayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        

       
    }
    

  
}
