//
//  SongFourViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/13.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongFourViewController: UIViewController {
    
    var labelOne: UILabel!
    var textOne: UITextView!
    var imange: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        labelOne = UILabel()
        view.addSubview(labelOne)
        labelOne.textColor = .white
        labelOne.text = "山丘"
        labelOne.font = UIFont.boldSystemFont(ofSize: 25)
        labelOne.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.height.equalTo(50)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.top.equalTo(view.snp.top).offset(20)
        }
        textOne = UITextView()
        view.addSubview(textOne)
        textOne.backgroundColor = .systemGray
        textOne.textColor = .cyan
        textOne.font = UIFont.boldSystemFont(ofSize: 20)
        textOne.textAlignment = .center
        textOne.text = """
想说却还没说的 还很多
攒着是因为想写成歌
让人轻轻地唱着 淡淡地记着
就算终于忘了 也值了
说不定我一生涓滴意念
侥幸汇成河
然后我俩各自一端
望着大河弯弯 终于敢放胆
嘻皮笑脸 面对 人生的难
也许我们从未成熟
还没能晓得 就快要老了
尽管心里活着的还是那个年轻人
因为不安而频频回首
无知地索求 羞耻于求救
不知疲倦地翻越 每一个山丘
越过山丘 虽然已白了头
喋喋不休 时不我予的哀愁
还未如愿见着不朽
就把自己先搞丢
越过山丘 才发现无人等候
喋喋不休 再也唤不回温柔
"""
        textOne.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(labelOne.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
        imange = UIImageView()
        view.addSubview(imange)
        imange.image = UIImage(named: "LiSun")
        imange.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(15)
        }

        
    }
    

   

}
