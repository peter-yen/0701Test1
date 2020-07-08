//
//  SearchTableViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var backOff: [String] = ["天空灰的像哭過", "當我和世界不一樣", "如果那兩個字沒有顫抖", "愛要拐幾個彎才來", "他靜悄悄的來過"]

     override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: "cell")

        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return backOff.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddTableViewCell
        
        let text = backOff[indexPath.row]
        cell.setTitle(text: text)
        return cell
    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = JayViewController()
            present(vc, animated: true, completion: nil)
        }else if indexPath.row == 1 {
            let vb = MayViewController()
            present(vb, animated: true, completion: nil)
        }else if indexPath.row == 2 {
            let vz = EasonViewController()
            present(vz, animated: true, completion: nil)
        }else if indexPath.row == 3 {
            let vx = SunViewController()
            present(vx, animated: true, completion: nil)
        }else if indexPath.row == 4 {
            let vv = JjlinViewController()
            present(vv, animated: true, completion: nil)
        }
//        func tableview(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if indexPath.row == 1 {
//                let vb = MayViewController()
//                present(vb, animated: true, completion: nil)
//            }
//        }

    }

}
