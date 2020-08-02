//
//  MainListController.swift
//  ChapterTest6
//
//  Created by 嚴啟睿 on 2020/7/25.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class MainListController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var delegate: MainListControllerDelegate!
    var itemToEdit: MainItem?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        if itemToEdit != nil {
            self.title = "編輯任務"
            self.textField.text = itemToEdit?.text
            self.doneButton.isEnabled = true
            
        }
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemDidCancel(controller: self)
    }
    
    
    @IBAction func done(_ sender: Any) {
        if self.itemToEdit == nil {
            let item = MainItem(text: textField.text!, checked: false)
            delegate?.addItem(controller: self, didFinishAddingItem: item)
        }else {
            self.itemToEdit?.text = self.textField.text!
            delegate?.addItem(controller: self, didFinishEditingItem: self.itemToEdit!)
            
        }
        
    }
    

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = textField.text!.replacingCharacters(in: range.toRange(string: textField.text!), with: string)
        doneButton.isEnabled = accessibilityElementCount() > 0
        // 這裡真的有點不了解 ElementCount 語法
        

            
        return true
    }
    
       

  
}


protocol MainListControllerDelegate {
    func addItemDidCancel(controller: MainListController)
    func addItem(controller: MainListController, didFinishAddingItem item: MainItem)
    func addItem(controller: MainListController, didFinishEditingItem item: MainItem)
    
    
    
    
}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = kCIUISetAdvanced.startIndex; self.location
        let endIndex = kCIUISetAdvanced.endIndex; self.length
        return startIndex..<endIndex
    }
}
