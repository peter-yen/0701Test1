//
//  MainController.swift
//  ChapterTest6
//
//  Created by 嚴啟睿 on 2020/7/24.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class MainController: UITableViewController, MainListControllerDelegate {
    var arrdata = [MainItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onCreateData()
        
//        print("沙盒資料和路徑:\(documentsDirectory())")
//        print("資料檔案途徑:\(dataFilePath())")
           
        
    }
    
        func onCreateData() {
            for i in 0...4 {
                var item = MainItem(text: "資料: \(i)", checked: true)
                arrdata.append(item)
            }
        }
            

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrdata.count
    }
        
    func configureCheckedmarkforCell(cell:UITableViewCell,item:MainItem) {
        var label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "✓"
        }else {
            label.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = arrdata[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as UITableViewCell
        let label = cell.viewWithTag(1000) as! UILabel
            
        label.text = item.text
        configureCheckedmarkforCell(cell: cell, item: item)
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arrdata[indexPath.row]
        item.toggleChecked()
        let cell = tableView.cellForRow(at: indexPath)
            configureCheckedmarkforCell(cell: cell!, item: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        arrdata.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueStr = "\(segue.identifier)"
        if segueStr == "AddItem" {
            segue}else if segueStr == "EditItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! MainListController
            controller.delegate = self
            let indexPath = self.tableView.indexPath(for: sender! as! UITableViewCell)
            controller.itemToEdit = arrdata[indexPath!.row]
        }
    }
    
    
    func addItemDidCancel(controller: MainListController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func addItem(controller: MainListController, didFinishAddingItem item: MainItem) {
        let newRowIndex = arrdata.count
        arrdata.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        self.tableView.insertRows(at:[indexPath], with: UITableView.RowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    
    func addItem(controller: MainListController, didFinishEditingItem item: MainItem) {
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    
    
    }
    
//    func documentsDirectory() -> String {
//        var paths = NSSearchPathForDirectoriesInDomains(FileManager.DocumentationDirectory, FileManager.UserDomainMask, true)
//        var documentsDirectory: String = paths.first as String
//        return documentsDirectory
//    }
//
//    func dataFilePath () ->String {
//        return self.documentsDirectory().stringByAppendingString("Checklists.plist")
//    }

}

