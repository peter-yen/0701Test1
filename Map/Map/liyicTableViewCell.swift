//
//  liyicTableViewCell.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/6.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class liyicTableViewCell: UITableViewCell {
    

    func settitle(text: String) {
        textLabel?.text = text
        imageView
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray
        
        
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
    
}
