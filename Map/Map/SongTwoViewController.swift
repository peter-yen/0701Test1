//
//  SongTwoViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/13.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongTwoViewController: UIViewController {
    var labelOne: UILabel!
    var textOne: UITextView!
    var imange: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        labelOne = UILabel()
        view.addSubview(labelOne)
        labelOne.text = "好朋友的祝福"
        labelOne.textColor = .white
        labelOne.font = UIFont.boldSystemFont(ofSize: 22)
        labelOne.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(15)
        }
        textOne = UITextView()
        view.addSubview(textOne)
        textOne.backgroundColor = .systemGray
        textOne.textColor = .cyan
        textOne.textAlignment = .center
        textOne.font = UIFont.boldSystemFont(ofSize: 20)
        textOne.text = """
           你的煙最後戒掉了嗎 這些年過得還算幸福嗎
        這咖啡的甜度 照舊是你愛的
        重逢的我們 一切卻都變了
        你問我還常常加班嗎 那口氣還是一樣的溫暖
        時間總是教人 把好的都記得
        當初為什麼 沒好好再見呢
        那年我失去最好朋友和我最愛的人
        你們相愛 我和悲傷共生共存
        而愛從不由人 對錯不會永恆
            但當時我只懂憎恨 你問我還常常加班嗎
            那口氣還是一樣的溫暖 時間總是教人 把好的都記得
        當初為什麼 沒好好再見呢
        那年我失去最好朋友和我最愛的人
        你們相愛 我和悲傷共生共存
        而愛從不由人 對錯不會永恆 但當時我只懂憎恨
        """
        textOne.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(labelOne.snp.bottom).offset(30)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
        }
        imange = UIImageView()
        view.addSubview(imange)
        imange.image = UIImage(named: "Alin")
        imange.contentMode = .scaleAspectFill
        imange.clipsToBounds = true
        imange.backgroundColor = .white
        imange.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(15)
        }
        
        

        
    }
    


}
