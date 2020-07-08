//
//  SongViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/5.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SongViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var mapLabel: UILabel!
    var songTableView: UITableView!
    var backOff: [String] = ["      天空灰的像哭過", "      當我和世界不一樣", "      如果那兩個字沒有顫抖", "      愛要拐幾個彎才來", "     他靜悄悄的來過"]
    var imageOne: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapLabel()
        setupSongTableView()
        Imageone()
    }
    func setupMapLabel() {
            
        mapLabel = UILabel.init()
        mapLabel.backgroundColor = .systemGreen
            mapLabel.textAlignment = .center
            mapLabel.font = UIFont.systemFont(ofSize: 30)
            view.addSubview(mapLabel)
//            mapLabel.translatesAutoresizingMaskIntoConstraints = false
            mapLabel.text = "歌名"
//            mapLabel.widthAnchor.constraint(equalToConstant: view.frame .width).isActive = true
//            mapLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            mapLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//            mapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }

    }

    func setupSongTableView() {
        songTableView = UITableView()
//        songTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songTableView)
        songTableView.backgroundColor = .cyan
    
//        songTableView.topAnchor.constraint(equalTo: mapLabel.bottomAnchor, constant: 0).isActive = true
//        songTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        songTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        songTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        songTableView.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(mapLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            songTableView.delegate = self
            songTableView.dataSource = self
            songTableView.register(liyicTableViewCell.self, forCellReuseIdentifier: "cell")
        }
         
        }
    func Imageone() {
        imageOne = UIImageView.init()
        view.addSubview(imageOne)
            imageOne.backgroundColor = .white
            imageOne.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(songTableView.snp.leading)
//            make.bottom.equalTo(songTableView.snp.top)
//
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return backOff.count
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! liyicTableViewCell
//        cell = tableViewCell(style: UITableViewCell.CellStyle, reuseIdentifier: "cell") as! liyicTableViewCell
        tableView.addSubview(self.imageOne)
        let text = backOff[indexPath.row]
        cell.settitle(text: text)
        
        
        
    
        return cell
        
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            mapLabel.text = "周杰倫:退後"
        case 1:
            mapLabel.text = "五月天:倔強"
        case 2:
            mapLabel.text = "陳奕迅:十年"
        case 3:
            mapLabel.text = "孫燕姿:遇見"
        case 4:
            mapLabel.text = "林俊傑:他說"
        default :
            break
            
        }
       
        
    }
}
