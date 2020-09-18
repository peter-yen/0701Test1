//
//  SpotsCollectionViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/16.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class SpotsCollectionViewController: UIViewController {
    var spots: [Spot] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
     var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        view.backgroundColor = .white

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

extension SpotsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpotCollectionViewCell
        let spot = spots[indexPath.item]
//        cell.spotViewController = self
        // 把自己給 SpotCollectionViewCell 裡面 SpotViewController 這個值
        
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
        
        let favoriteSpotsViewController = FavoriteSpotsViewController()
        
        spotDetailViewController.spot = spot
        
        //        favoriteSpotsViewController.spot = spot
        
        navigationController?.pushViewController(spotDetailViewController, animated: true)
        
    }
    
    
}
extension SpotsCollectionViewController: UISearchTextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) //  TouchesBegan 沒有用
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
