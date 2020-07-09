//
//  liyicTableViewCell.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/6.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class liyicTableViewCell: UITableViewCell {
    var imageOne: UIImageView!
    var singerLabel: UILabel!
    var songLabel: UILabel!
    
    

    func settitle(text: String) {
        textLabel?.text = text
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray
        
        
      
    }
    func image() {
        addSubview(imageOne)
        imageOne = UIImageView()
//        imageOne.image = UIimage(name: "iosph")
        backgroundColor = .black
        imageOne.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview()
            make.width.height.equalTo(40)
            make.top.equalToSuperview()
            
        }
        
        
    }
    func labelOne() {
        addSubview(singerLabel)
        singerLabel = UILabel()
        singerLabel.textColor = .white
        singerLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(25)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        
    }
    func labelTwo() {
        addSubview(songLabel)
        songLabel = UILabel()
        songLabel.textColor = .white
        songLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(25)
            make.top.equalTo(singerLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
}
