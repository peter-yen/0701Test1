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

class SpotsViewController: UIViewController {
    var collectionView: UICollectionView!
    var name: String = ""
    var spots: [Spot] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        title = "台北市"
        
        setupCollectionView()
        
        HUD.shared.showLoading(view: view)
        
        Firestore.firestore().collection("Spots").getDocuments { (snapshots, error) in
            if let error = error {
                self.view.makeToast(error.localizedDescription)
                return
            }
            if let snapshots = snapshots?.documents {
                for snapshot in snapshots {
                    let dictionary = snapshot.data()
                    let spot = Spot(firestoreDictionary: dictionary)
                    self.spots.append(spot)
                    
                }
                DispatchQueue.main.async { //執行緒
                self.collectionView.reloadData()
                }
                HUD.shared.hideLoading()
            }
        }
        
    }
    
    
  
//    for dictionary in info {
//        if let dictionary = dictionary as? [String: Any] {
//            let spot = Spot(dictionary: dictionary)
//            self.spots.append(spot)
//        }
//
//    }
    
//    }
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

extension SpotsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpotCollectionViewCell
        let spot = spots[indexPath.item]
        let url = URL(string: spot.picture1)
        cell.backgroundImageView.sd_setImage(with: url, completed: nil)
        cell.nameLabel.text = spot.name
        cell.addressLabel.text = spot.address
        cell.townLabel.text = spot.district
        cell.spot = spot
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 5
        let size = CGSize(width: width, height: 180)
        
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let spot = spots[indexPath.item]
        let spotDetailViewController = SpotDetailViewController()
        spotDetailViewController.spot = spot
        navigationController?.pushViewController(spotDetailViewController, animated: true)
        
       
    }
 

}
extension SpotsViewController: UISearchTextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) //  TouchesBegan 沒有用
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
