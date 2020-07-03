//
//  FirstTableViewController.swift
//  0701
//
//  Created by gary chen on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
  
  var addItemButton: UIButton!
  
  var animals: [String] = ["cat", "dog", "mouse", "pigg"]
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(AddItemTableViewCell.self, forCellReuseIdentifier: "cell")
    
    view.backgroundColor = .green
    print("firstTable view did load")
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print("firstTable view did appear")
    
    
    addItemButton = UIButton()
    addItemButton.setImage(UIImage(named: "add"), for: .normal)
    tableView.addSubview(addItemButton)
    addItemButton.translatesAutoresizingMaskIntoConstraints = false
    
    addItemButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
    addItemButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    //    addItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    //    addItemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -30).isActive = true
    addItemButton.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    addItemButton.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    addItemButton.addTarget(self, action: #selector(addItemButtonDidTap), for: .touchUpInside)
    //    view.bringSubviewToFront(addItemButton)
    
  }
  
  @objc func addItemButtonDidTap() {
    print("sssssss")
    let vc = AddItemViewController()
    present(vc, animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("firstTable view will appear")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return animals.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddItemTableViewCell
//    cell.textLabel?.text = animals[indexPath.row]
    let text = animals[indexPath.row]
    cell.setTitle(text: text)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      print("準備顯示second")
      var vc = SecondViewController()
      present(vc, animated: true, completion: nil)
    }
  }
  
}
