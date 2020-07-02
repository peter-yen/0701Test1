//
//  FirstViewController.swift
//  0701
//
//  Created by 嚴啟睿 on 2020/7/1.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let label = UILabel()
        label.text = "Nice"
        label.textColor = .darkGray
        label.backgroundColor = .red
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        
        let myView = UIView()
        myView.backgroundColor = .red
        view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        myView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 40 ).isActive = true
        myView.topAnchor.constraint(equalTo: label.topAnchor, constant: 0 ).isActive = true
        
        
        

    }
    

}
