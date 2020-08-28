//
//  PostViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class SpotsViewController: UIViewController {
    var collectionView: UICollectionView!
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        setupCollectionView()
        
        
        let text = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        let url = URL(string: text)
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    if let json = json ,
                        let xmlHead = json["XML_Head"] as? [String:Any],
                        let infos = xmlHead["Infos"] as? [String:Any] ,
                        let info = infos["Info"] as? [Any],
                        let infoArray = info[0] as? [String:Any],
                        let id = infoArray["Id"] as? String ,
                        let name = infoArray["Name"] as? String ,
                        let toldescribe = infoArray["Toldescribe"] as? String ,
                        let tel = infoArray["Tel"] as? String ,
                        let region = infoArray["Region"] as? String ,
                        let town = infoArray["Town"] as? String ,
                        let px = infoArray["Px"] as? Double ,
                        let py = infoArray["Py"] as? Double  ,
                        let keyword = infoArray["Keyword"] as? String {
                        self.name = name
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        print("""
                            Id: \(id),
                            Name: \(name),
                            Toldescribe: \(toldescribe),
                            Tel: \(tel),
                            Region: \(region),
                            Town: \(town),
                            Px: \(px),
                            Py: \(py),
                            Keyword: \(keyword)
                            """)
                    }
                    
                }
            }.resume()
            
        }
        
    }
    func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical // vertical 垂直的意思，   horizontal 橫向的意思
           collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
           
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
           collectionView.backgroundColor = .green
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CityCollectionViewCell
        cell.nameLabel.text = name
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
