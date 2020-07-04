//
//  HomeViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let viewOne = UIImageView()
        viewOne.backgroundColor = .red
        view.addSubview(viewOne)
        viewOne.translatesAutoresizingMaskIntoConstraints = false
        viewOne.widthAnchor.constraint(equalToConstant: 50).isActive = true
        viewOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        viewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        viewOne.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        let labelOne = UILabel()
        labelOne.backgroundColor = .red
        labelOne.text = "      Hello"
        labelOne.textColor = .white
        view.addSubview(labelOne)
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.widthAnchor.constraint(equalToConstant: 100).isActive = true
        labelOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelOne.leadingAnchor.constraint(equalTo: viewOne.trailingAnchor, constant: 55 ).isActive = true
        labelOne.topAnchor.constraint(equalTo: viewOne.topAnchor, constant: 0 ).isActive = true
                      
        let buttonOne = UIButton()
        buttonOne.backgroundColor = .red
        buttonOne.setTitle("World", for: .normal)
        buttonOne.setTitleColor(.blue, for: .normal)
        view.addSubview(buttonOne)
            //        buttonOne.tintColor = .black
            //        buttonOne.titleLabel?.text = "World" 這兩行是舊的，無法使用
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        buttonOne.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonOne.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                      
    }
    

  
}
