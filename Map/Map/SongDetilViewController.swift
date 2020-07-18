//
//  SongDetilViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/18.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongDetilViewController: UIViewController {
    var songTitleLabel: UILabel!
    var lyricTextView: UITextView!
    var singerImageView: UIImageView!
    var songTitle: String = ""
    var songText: String = ""
    var singerImageTitle: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        
        songTitleLabel = UILabel()
        view.addSubview(songTitleLabel)
        songTitleLabel.textColor = .white
        songTitleLabel.text = songTitle
        songTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        songTitleLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(15)
        }
        
        
        lyricTextView = UITextView()
        view.addSubview(lyricTextView)
        lyricTextView.backgroundColor = .systemGray
        lyricTextView.textColor = .cyan
        lyricTextView.font = UIFont.boldSystemFont(ofSize: 20)
        lyricTextView.text = songText
        lyricTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(songTitleLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
        singerImageView = UIImageView()
        view.addSubview(singerImageView)
        singerImageView.image = UIImage(named: singerImageTitle)
        singerImageView.backgroundColor = .white
        
        singerImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(20)
        }
        
        

    }
    
    

   
}
