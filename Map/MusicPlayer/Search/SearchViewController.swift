//
//  SearchViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class SearchViewController: UIViewController {
    
    var searchTextField: UISearchTextField!
    var collectionView: UICollectionView!
    var cityArray: [[CityEnum: [String]]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
            Firestore.firestore().collection("Cities").getDocuments { (snapshot, err) in
                if let err = err {
                    self.view.makeToast(err.localizedDescription)
                    return
                }
                if let snapshots = snapshot?.documents {
                    for snapshot in snapshots {
                        
                        var citydictionary: [CityEnum: [String]] = [:]
                        let dict = snapshot.data()
                        if let cityIds = snapshot["cityIds"] as? [String] {
                            let cityName = snapshot.documentID
                            if let cityEnum = CityEnum(rawValue: cityName) {
                                citydictionary[cityEnum] = cityIds
                            }
                            
                        }
                        self.cityArray.append(citydictionary)
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            
        }
        
        
        
        
        
        configurLayout()
        setupCollectionView()
    }
    
    func configurLayout() {
        title = "搜尋城市"
        
        searchTextField = UISearchTextField()
        view.addSubview(searchTextField)
//        searchTextField.keyboardType = .asciiCapable
        searchTextField.delegate = self
        searchTextField.snp.makeConstraints { (m) in
            m.trailing.equalTo(view.snp.trailing).offset(-10)
            m.left.equalTo(view.snp.left).offset(10)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            m.height.equalTo(40)
        }
        
        
            }
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // vertical 垂直的意思，   horizontal 橫向的意思
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .cyan
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(10)
            m.bottom.trailing.equalToSuperview().offset(-10)
            m.top.equalTo(searchTextField.snp.bottom).offset(20)
            
        }
        
    }
    

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CityCollectionViewCell
        
        let cityDict = self.cityArray[indexPath.item]
        
        if let cityEnum = cityDict.keys.first {
            cell.nameLabel.text = cityEnum.rawValue
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
//        var hight: CGFloat = 0
//        if indexPath.item % 2 == 1 {
//            hight = 150
//        } else {
//            hight = 90
//        }
        let size = CGSize(width: width, height: 150)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cityDict = self.cityArray[indexPath.item]
               
               if let cityEnum = cityDict.keys.first {
                if let cityIds = cityDict[cityEnum] {
                    print("city: \(cityIds)")
                    
                    // 拿到 桃園市所有的 city id, 傳到 spotVC
                    let spotsViewController = SpotsViewController()
                    
                    spotsViewController.spotIds = cityIds
                    spotsViewController.cityTitle = cityEnum.rawValue
                    
                        navigationController?.pushViewController(spotsViewController, animated: true)
                }
               }
        
        
    
    }
    
    
}
extension SearchViewController: UISearchTextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) //  TouchesBegan 沒有用
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
