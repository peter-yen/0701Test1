//
//  PostViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage
import FirebaseFirestore
import FirebaseAuth

class SpotsViewController: UIViewController {
    
    var spotsMapViewController: SpotsMapViewController!
    var spotsCollectionViewController: SpotsCollectionViewController!
    var currentViewController: UIViewController!
   
    var segmentControl: UISegmentedControl!
    var name: String = ""
    var spots: [Spot] = [] {
        didSet {
            print("spots:", spots)
            spotsCollectionViewController.spots = spots
        }
    }
    var favoriteSpotsIDs: [String] = []
    var spotIds: [String] = []
    var cityTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        
        title = cityTitle
        
        setupSegmentControl()
        
        self.spotsCollectionViewController = SpotsCollectionViewController()
//        let spotsCollectionNavigationController = UINavigationController(rootViewController: self.spotsCollectionViewController)
        self.spotsMapViewController = SpotsMapViewController()
        
        currentViewController = spotsCollectionViewController // 預設
        
        
        self.view.addSubview(currentViewController.view)
            currentViewController.view.snp.makeConstraints { (m) in
                m.edges.equalToSuperview()
            }
            currentViewController.didMove(toParent: self)
            self.view.bringSubviewToFront(segmentControl)
        
        
        getSpots { (spots) in
    // 把這個封包的 spots 傳給 self.spots 讓他傳到 spotsCollectionViewController
            self.spots = spots
        }
    }
    
    func getSpots(completion: @escaping ([Spot]) -> Void) {
        
    
        HUD.shared.showLoading(view: view)
        let dispatchGroup = DispatchGroup()
        // 執行緒
      // for loop 找 cityIds 內的 spot , 存入陣列 -> reloadData 顯示資料
        for id in spotIds {
            
            dispatchGroup.enter()
            
            Firestore.firestore().collection("Spots").document(id).getDocument { (snapshots, error) in
                if let error = error {
                    self.view.makeToast(error.localizedDescription)
                    return
                }
                if let dict = snapshots?.data() {
                    let spot = Spot(firestoreDictionary: dict)
                    self.spots.append(spot)
                }
                
                dispatchGroup.leave()
                
            }
        }
        if let uid = Auth.auth().currentUser?.uid {
            
            dispatchGroup.enter()
            
            API.shared.userRef(uid: uid).getDocument { (snapshot, err) in
                if let err = err {
                    self.view.makeToast(err.localizedDescription)
                    return
                }
                if let data = snapshot?.data() {
                    if let favoriteSpotsArray = data["favoriteSpots"] as? [String] {
                        self.favoriteSpotsIDs = favoriteSpotsArray
                        
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            HUD.shared.hideLoading()
        }
    }
    
    
    
    func setupSegmentControl() {
        segmentControl = UISegmentedControl(items: ["列表", "地圖"])
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { (m) in
            m.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            m.centerX.equalToSuperview()
        }
        segmentControl.addTarget(self, action: #selector(segmentControlDidChanged), for: .valueChanged)
    }
    @objc func segmentControlDidChanged(_ sender: UISegmentedControl!) {
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParent()
        
        if sender.selectedSegmentIndex == 0 {
            currentViewController = spotsCollectionViewController
            
        } else {
            currentViewController = spotsMapViewController
            
        }
        self.view.addSubview(currentViewController.view)
        currentViewController.view.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        currentViewController.didMove(toParent: self)
        self.view.bringSubviewToFront(segmentControl)
    }
    
}

