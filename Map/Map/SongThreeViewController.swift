//
//  SongThreeViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/13.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongThreeViewController: UIViewController {
    var labelOne: UILabel!
    var textOne: UITextView!
    var imange: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        labelOne = UILabel()
        view.addSubview(labelOne)
        labelOne.textColor = .white
        labelOne.text = "掉了"
        labelOne.font = UIFont.boldSystemFont(ofSize: 25)
        labelOne.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(80)
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
心疼的玫瑰 半夜還開著 找不到匆匆掉落的花蕊
回到現場卻已來不及 等待任何回音都不可得
微弱的風箏 冬天裡飄著 回不去手中纏線的那個
沒有藍天 又何必去飛 怎麼適合
黑色笑靨掉了 雪白眼淚掉了 該出現的所有表情瞬間掉了
瞳孔沒有顏色 結了冰的長河 回憶是最可怕的敵人
故事情節掉了 主角對白掉了 該屬於劇中的對角戲也掉了
胸口沒有快樂 斷了翅的白鴿 不枯萎的藉口全掉了
曾經唱過的歌 分享過的笑聲 在心中不斷拉扯
想念不能承認 偷偷擦去淚痕 冬天過了還是會很冷
黑色笑靨掉了 雪白眼淚掉了 該出現的所有表情瞬間掉了
"""
        textOne.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(labelOne.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
        }
        imange = UIImageView()
        view.addSubview(imange)
        imange.image = UIImage(named: "Zhan")
        imange.contentMode = .scaleAspectFill
        imange.clipsToBounds = true
        imange.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(15)
        }
        

    }
    

    
    

}
