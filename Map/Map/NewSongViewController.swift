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
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! liyicTableViewCell
        let text = song[indexPath.row]
        
        cell.imageOne?.image = UIImage(named: song[indexPath.row])
        cell.settitle(text: text)
        cell.detailTextLabel?.text = "ssd"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    var singerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        }
    
    func setTableView() {
//        singerTableView
        singerTableView = UITableView()
        view.addSubview(singerTableView)
        singerTableView.separatorColor = .white
        singerTableView.backgroundColor = .systemRed
        singerTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top).offset(50)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            singerTableView.delegate = self
            singerTableView.dataSource = self
            singerTableView.register(liyicTableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    }
    

    


