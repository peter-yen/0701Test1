//
//  SongFiveViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/13.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongFiveViewController: UIViewController {
    var labelOne: UILabel!
    var textOne: UITextView!
    var imange: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        labelOne = UILabel()
        view.addSubview(labelOne)
        labelOne.textColor = .white
        labelOne.font = UIFont.boldSystemFont(ofSize: 19)
        labelOne.text = "我想我不會愛你"
        labelOne.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalToSuperview()
        }
        textOne = UITextView()
        view.addSubview(textOne)
        textOne.backgroundColor = .systemGray
        textOne.textColor = .cyan
        textOne.textAlignment = .center
        textOne.font = UIFont.boldSystemFont(ofSize: 18)
        textOne.text = """
你的呼吸 穿過身體 我來不及反應
你的聲音 躲在耳裡 讓我生病

謝謝 你給的讓我沉迷 讓我丟掉了姓名
在好奇的時候 拉不住眼睛

我想我不會愛你 這樣下去 渺小的自尊都快要拋棄
我想我不會愛你 只是也許

你的嘆息 散落一地 讓我歇斯底里
靠得太近 一不小心 弄傷自己

謝謝 你給的讓我沉迷 讓我困住了自己
在迷路的時候 捨不得離去

我想我不會愛你 這樣下去 渺小的自尊都快要拋棄
我想我不會恨你 傷的痕跡 住在我心底變成了祕密
我想我不會愛你 害怕失去 所以逞強的遠遠看著你
我想我不會恨你 只是也許
"""
        textOne.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(labelOne.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
        imange = UIImageView()
        view.addSubview(imange)
        imange.image = UIImage(named: "Hebe")
        imange.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(15)
        }

        
    }
    

   

}
