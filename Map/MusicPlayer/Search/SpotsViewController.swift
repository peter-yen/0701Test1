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

class SpotsViewController: UIViewController {
    var collectionView: UICollectionView!
    var name: String = ""
    var spots: [Spot] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        title = "台北市"
        
        setupCollectionView()
        
        
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
                                self.spots.append(spot)
                            }
                            
                        }
                        DispatchQueue.main.async { //執行緒
                            self.collectionView.reloadData()
                        }
                       
                    }
                    HUD.shared.hideLoading()

                }            }.resume()
            
        }
        
    }
  
 
    func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical // vertical 垂直的意思，   horizontal 橫向的意思
        layout.minimumLineSpacing = 40.0
        // 上面是調整垂直滑動，每個cell上下之間的間距方法
           collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.register(SpotCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .black
           view.addSubview(collectionView)
           collectionView.snp.makeConstraints { (m) in
               m.leading.equalToSuperview().offset(10)
               m.bottom.trailing.equalToSuperview().offset(-10)
               m.top.equalTo(view.snp.top).offset(20)
               
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
        cell.addressLabel.text = spot.add
        cell.townLabel.text = spot.town
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let size = CGSize(width: width, height: 150)
        
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
