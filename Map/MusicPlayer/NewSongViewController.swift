//
//  NewSongViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/9.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

//delegate拉出去做 extension
class NewSongViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    var musicArray: [Music] = []
   
//    var images = []
    override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    createMusic()
//      navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    
    func createMusic () {
        let music1 = Music(singer: "米津玄師", song: "Loser", imangeArray: "KenShi", lyric: """
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
""")
        let music2 = Music(singer: "A-Lin", song: "好朋友的祝福", imangeArray: "Alin", lyric: """
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
        
""")
        let music3 = Music(singer: "張惠妹", song: "掉了", imangeArray: "Zhan", lyric: """
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
""")
        let music4 = Music(singer: "李宗盛", song: "山丘", imangeArray: "LiSun", lyric: """
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
""")
        let music5 = Music(singer: "田馥甄", song: "我想我不會愛你", imangeArray: "Hebe", lyric: """
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
        """)
        self.musicArray = [music1, music2, music3, music4, music5]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
      
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0: return "Section 0"
        default: return "Section \(section)"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LiyicTableViewCell
        var songArray = musicArray[indexPath.row]
        
        cell.songLabel.text = songArray.song
        cell.singerLabel.text = songArray.singer
        cell.singerImageView.image = UIImage(named: songArray.imangeArray)
        
//        cell.imageOne.image =  images[indexPath.row]
        
        



        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var songArray = musicArray[indexPath.row]
         let vc = SongDetilViewController()
        vc.songTitle = songArray.song
        vc.songText = songArray.lyric
        vc.singerImageTitle = songArray.imangeArray
        present(vc,animated: true, completion: nil)
                                                                        
    }
        //作業。 按一下跳出一個viewcontroller
        
    
    var singerTableView: UITableView!
    
    
    
    func setTableView() {
//        singerTableView
        singerTableView = UITableView()
        view.addSubview(singerTableView)
//        singerTableView.separatorColor = .black
        singerTableView.backgroundColor = .white
        singerTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top).offset(50)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            singerTableView.delegate = self
            singerTableView.dataSource = self
            singerTableView.register(LiyicTableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
}
    

    


