//
//  NewSongViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/9.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class NewSongViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    var singer = ["米津玄師", "A-Lin", "張惠妹", "李宗盛", "田馥甄"]
    var song = ["Loser", "好朋友的祝福", "掉了", "山丘", "我想我不會愛你"]
//    var images = []
    override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        song.count
        
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0: return "Section 0"
        default: return "Section \(section)"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LiyicTableViewCell
        cell.songLabel.text = song[indexPath.row]
        cell.singerLabel.text = singer[indexPath.row]
        
//        cell.imageOne.image =  images[indexPath.row]
        
        



        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = SongOneViewController()
            present(vc, animated: true, completion: nil)
        }else if indexPath.row == 1 {
            let vc1 = SongTwoViewController()
            present(vc1, animated: true, completion: nil)
        }else if indexPath.row == 2 {
            let vc2 = SongThreeViewController()
            present(vc2, animated: true, completion: nil)
        }else if indexPath.row == 3 {
            let vc3 = SongFourViewController()
            present(vc3, animated: true, completion: nil)
        }else if indexPath.row == 4 {
            let vc4 = SongFiveViewController()
            present(vc4, animated: true, completion: nil)
        }
        //作業。 按一下跳出一個viewcontroller
        
    }
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
    

    


