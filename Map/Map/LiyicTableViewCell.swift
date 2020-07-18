//
//  liyicTableViewCell.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/6.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class LiyicTableViewCell: UITableViewCell {
    var singerImageView: UIImageView!
    var songLabel: UILabel!
    var singerLabel: UILabel!
    
    

    func settitle(text: String) {
        textLabel?.text = text
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupImageView()
        setupSongLabel()
        setupSingerLabel()
                
      
    }
    func setupImageView() {
        singerImageView = UIImageView()
        addSubview(singerImageView)
        singerImageView.image = UIImage(named: "song1")
        singerImageView.contentMode = .scaleAspectFill //調整比例
        singerImageView.clipsToBounds = true //擷取邊界 ＴＲＵＥ就是擷取
//        imageOne.backgroundColor = .red
        singerImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview()
            make.width.height.equalTo(50)
//            make.top.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY)
        }
        
        
    }
    func setupSongLabel() {
        songLabel = UILabel()
        addSubview(songLabel)
        songLabel.text = "歌名"
//        songLabel.backgroundColor = .blue
        songLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(singerImageView.snp.trailing).offset(15)
            make.top.equalTo(self.snp.top).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
            make.height.equalTo(25)
        }
        
        
    }
    func setupSingerLabel() {
        singerLabel = UILabel()
        addSubview(singerLabel)
        singerLabel.text = "歌手"
//        singerLabel.backgroundColor = .green
        singerLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(songLabel.snp.leading)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.trailing.equalTo(songLabel.snp.trailing)
            make.height.equalTo(songLabel.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
}
