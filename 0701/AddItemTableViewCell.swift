//
//  AddItemTableViewCell.swift
//  0701
//
//  Created by gary chen on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class AddItemTableViewCell: UITableViewCell {

  
  func setTitle(text: String) {
    textLabel?.text = text
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
    backgroundColor = .blue
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  

}
