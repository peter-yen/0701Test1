//
//  SongOneViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/12.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongOneViewController: UIViewController {
    var labelOne: UILabel!
    var textOne: UITextView!
    var imageKenShi: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        labelOne = UILabel()
        view.addSubview(labelOne)
        labelOne.textColor = .white
        labelOne.text = "Loser"
        labelOne.font = UIFont.boldSystemFont(ofSize: 30)
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
        textOne.font = UIFont.boldSystemFont(ofSize: 20)
        
        textOne.text = """
いつもどおりの通り独り こんな日々もはや懲り懲り
        もうどこにも行けやしないのに夢見ておやすみ
        いつでも僕らはこんな風にぼんくらな夜に飽き飽き
        また踊り踊り出す明日に出会うためにさよなら歩き
        回ってやっとついた ここはどうだ楽園か?
        今となっちゃもうわからない四半世紀の結果出来た
        青い顔のスーパースターがお腹すかしては待ってる
        アイムアルーザー どうせだったら遠吠えだっていいだろう
        もう一回もう一回行こうぜ 僕らの声
        アイムアルーザー ずっと前から聞こえてた
        いつかポケットに隠した声が
"""
        textOne.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(labelOne.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
        imageKenShi = UIImageView()
        view.addSubview(imageKenShi)
        imageKenShi.image = UIImage(named: "KenShi")
        imageKenShi.backgroundColor = .white
        imageKenShi.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(20)
        }
        
        

    }
    
    

   
}
