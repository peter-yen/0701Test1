//
//  FavoriteSpotsViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/4.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Toast_Swift

class FavoriteSpotsViewController: UIViewController {
    var collectionView: UICollectionView!
    var name: String = ""
    var favoriteSpots: [Spot] = []
    var favoriteSpotsIDs: [String] = []
    var spotsViewCOntroller: SpotsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        title = "我的收藏"
        
        setupCollectionView()
        
        HUD.shared.showLoading(view: view)
        
        if let uid = Auth.auth().currentUser?.uid {
            API.shared.userRef(uid: uid).getDocument { (snapshot, err) in
                if let err = err {
                    self.view.makeToast(err.localizedDescription)
                    return
                }
                if let data = snapshot?.data() {
                    if let favoriteSpotsArray = data["favoriteSpots"] as? [String] {
                        self.favoriteSpotsIDs = favoriteSpotsArray
                        
                        for id in self.favoriteSpotsIDs {
                            
                            let dispatchGroup = DispatchGroup()
                            
                            dispatchGroup.enter()
                            
                            Firestore.firestore().collection("Spots").document(id).getDocument { (snapshot, errr) in
                                if let err = err {
                                    self.view.makeToast(err.localizedDescription)
                                    return
                                }
                                if let dict = snapshot?.data() {
                                    let spot = Spot(firestoreDictionary: dict)
                                    
                                    self.favoriteSpots.append(spot)
                                    
                                }
                                dispatchGroup.leave()
                                
                                
                            }
                            dispatchGroup.notify(queue: .main) {
                                self.collectionView.reloadData()
                                
                                HUD.shared.hideLoading()
                            }
                        }
                        
                    }
                }
                
            }
        }
        
        
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // vertical 垂直的意思，   horizontal 橫向的意思
        layout.minimumLineSpacing = 80.0
        // 上面是調整垂直滑動，每個cell上下之間的間距方法
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SpotCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(5)
            m.bottom.trailing.equalToSuperview().offset(-5)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
        }
        
    }
    
}

extension FavoriteSpotsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteSpots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpotCollectionViewCell
        let spot = favoriteSpots[indexPath.item]
        cell.favoriteSpotsViewCOntroller = self
        //        cell.spotViewController == nil
        //        cell.favoriteSpotsViewCOntroller != nil
        cell.spot = spot
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 5
        let size = CGSize(width: width, height: 180)
        
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let spotDetailViewController = SpotDetailViewController()
        
        
        
        //        spotDetailViewController.spot = favoriteSpots
        
        
        
        
        navigationController?.pushViewController(spotDetailViewController, animated: true)
        
    }
    
    
}
extension FavoriteSpotsViewController: UISearchTextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) //  TouchesBegan 沒有用
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
