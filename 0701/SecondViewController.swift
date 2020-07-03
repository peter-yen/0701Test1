//
//  SecondViewController.swift
//  0701
//
//  Created by 嚴啟睿 on 2020/7/1.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .blue
    
    print(#function)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    print(#function)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidLoad()
    print(#function)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print(#function)
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print(#function)
  }
  
  
}
