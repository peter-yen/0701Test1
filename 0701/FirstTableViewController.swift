//
//  FirstTableViewController.swift
//  0701
//
//  Created by gary chen on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
    print("firstTable view did load")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print("firstTable view did appear")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("firstTable view will appear")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("section: \(indexPath.section)")
    print("row: \(indexPath.row)")
    
    var cell = UITableViewCell()
    cell.textLabel?.text = "hello"
    cell.backgroundColor = .blue
    cell.textLabel?.textAlignment = .center
    
    if indexPath.row == 2 {
      cell.textLabel?.text = "nononoo"
    } else if indexPath.row == 1 {
      cell.backgroundColor = .yellow
    }
    
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
