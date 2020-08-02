//
//  AllListViewController.swift
//  ChapterTest6
//
//  Created by 嚴啟睿 on 2020/7/31.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
      var lists = [Checklist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onCreateData()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func onCreateData() {
        for i in 0...4 {
            var item = Checklist(name: "任務類別:\(i)")
            lists.append(item)
              }
          }


//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return lists.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell!.textLabel?.text = lists[indexPath.row].name
        cell!.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        return cell!
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowChecklist", sender: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    
   

}
