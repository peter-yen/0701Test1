//
//  AddTableViewCell.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell {

    func setTitle(text: String) { 
        textLabel?.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .cyan

        
    }

}
