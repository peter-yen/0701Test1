//
//  AddItemViewController.swift
//  0701
//
//  Created by gary chen on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .purple
        
      
      let label = UILabel()
      label.text = "Nice"
      label.textColor = .darkGray
      label.backgroundColor = .red
      view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.widthAnchor.constraint(equalToConstant: 40).isActive = true
      label.heightAnchor.constraint(equalToConstant: 30).isActive = true
      label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
      label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    

}
