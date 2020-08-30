//
//  TabBarViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       updateAPI()
        view.backgroundColor = .white
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem.image = UIImage(named: "search")
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        
        let profileViewController = ProfileViewController()
        
        profileViewController.tabBarItem.image = UIImage(named: "iosph")
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        viewControllers = [searchNavigationController , profileNavigationController]
        

        
    }

    
    override func viewDidAppear(_ animated: Bool) { //程式跑的時間太快，在viewDidLoad打會出現不及
        super.viewDidAppear(animated)
        print("viewDidApear")
        
                if let user = Auth.auth().currentUser {
            view.makeToast("Nice to meet you")
        } else {
            let authViewController = AuthViewController()
            let authNavigationController = UINavigationController(rootViewController: authViewController)
                    authNavigationController.isModalInPresentation = true
                    //上面的是，present的視窗不會被拉下來
//                    authViewController.modalPresentationStyle = .fullScreen
            present(authNavigationController, animated: true, completion: nil)
        }

    }
    func updateAPI() {
        let text = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        let url = URL(string: text)
        if let url = url {
            
            HUD.shared.showLoading(view: view)
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    if let json = json ,
                        let xmlHead = json["XML_Head"] as? [String:Any],
                        let infos = xmlHead["Infos"] as? [String:Any] ,
                        let info = infos["Info"] as? [Any] {
                        for dictionary in info {
                            if let dictionary = dictionary as? [String: Any] {
                                let spot = Spot(dictionary: dictionary)
                                let dictionary = spot.dictionary()
//                                print("dict: \(dictionary)")
                                Firestore.firestore().collection("Spots").document(spot.id).setData(dictionary) { (error) in
                                    if let error = error {
                                        self.view.makeToast(error.localizedDescription)
                                        print("失敗上傳 :\(error.localizedDescription)")
                                        return
                                    }
                                    self.view.makeToast("成功上傳API")
                                    print("成功上傳: \(spot.id)")
                                }
                                
                            }
                            
                        }
                      
                    }
                    HUD.shared.hideLoading()

                }            }.resume()
            
        }
    }
    
}
