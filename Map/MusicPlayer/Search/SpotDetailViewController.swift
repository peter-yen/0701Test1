//
//  SpotDetailViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class SpotDetailViewController: UIViewController, MKMapViewDelegate {
    var spot: Spot!
    convenience init(spot: Spot) {
        self.init()
        self.spot = spot
    }
    lazy var backgroundImageView: UIImageView = {
       let bi = UIImageView()
        bi.contentMode = .scaleAspectFill
        bi.clipsToBounds = true
        return bi
    }()
    var descriptionTextView: UITextView!
    lazy var addressLabel: UILabel = {
        let al = UILabel()
        al.font = UIFont.boldSystemFont(ofSize: 18)
        al.textColor = .systemBlue
        return al
    }()
    lazy var townLabel: UILabel = {
       let tl = UILabel()
        tl.font = UIFont.boldSystemFont(ofSize: 20)
        tl.textColor = .systemBlue
        return tl
    }()
    lazy var telLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.boldSystemFont(ofSize: 18)
        tl.textColor = .systemBlue
        return tl

    }()
    lazy var opentimeLabel: UILabel = {
       let op = UILabel()
        op.font = UIFont.boldSystemFont(ofSize: 18)
        op.textColor = .systemBlue
        return op
    }()
     lazy var introductionLabel: UILabel = {
        let il = UILabel()
        il.font = UIFont.boldSystemFont(ofSize: 18)
        il.textColor = .systemIndigo
        il.text = "- 景點介紹 -"
        return il
    }()
    lazy var travellingLabel: UILabel = {
       let tl = UILabel()
        tl.font = UIFont.boldSystemFont(ofSize: 18)
        tl.textColor = .systemIndigo
        tl.text = "- 交通資訊 -"
        return tl
    }()
    var travellinginfoTextView: UITextView!
    var mapView: MKMapView!
    var scrollView: UIScrollView! //UIScrollView 是可以垂直滑動的一種View
    lazy var mapLabel: UILabel = {
       let ml = UILabel()
        ml.font = UIFont.boldSystemFont(ofSize: 18)
        ml.text = "- 地圖資訊 -"
        ml.textColor = .systemIndigo
        return ml
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = spot.name
        
        // 從 FavoriteSpotsViewController 點進去 Title spot.name 抓不到
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //設置Title滑動後的效果
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        //上面設置title的顏色和大小
        self.scrollView = UIScrollView()
        view.addSubview(scrollView)
        self.scrollView.backgroundColor = .white
        self.scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        self.scrollView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        self.setupSpaceImageView()
        self.setupLabel()
        self.setupTextView()
        self.setupMapView()
        
    }
    
    func setupSpaceImageView() {
        self.scrollView.addSubview(backgroundImageView)
        let url = URL(string: spot.picture1)
        self.backgroundImageView.sd_setImage(with: url, completed: nil)
        self.backgroundImageView.snp.makeConstraints { (m) in
            m.top.equalTo(scrollView.snp.top)
            m.width.equalToSuperview()
            m.height.equalTo(250)
            m.centerX.equalToSuperview()
            
        }
    }
    
    func setupLabel() {
        self.scrollView.addSubview(townLabel)
        self.townLabel.text = " 台灣 \(spot.district)"
        self.townLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(backgroundImageView.snp.bottom)
            m.left.equalTo(backgroundImageView.snp.left).offset(5)
        }
        self.scrollView.addSubview(addressLabel)
        self.addressLabel.text = "地址: \(spot.address)"
        self.addressLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(townLabel.snp.bottom).offset(5)
            m.left.equalTo(townLabel).offset(5)
        }
        self.scrollView.addSubview(opentimeLabel)
        self.opentimeLabel.text = "開放時間： \(spot.opentime)"
        self.opentimeLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(addressLabel.snp.bottom).offset(5)
            m.left.equalTo(townLabel).offset(5)
        }
        self.scrollView.addSubview(telLabel)
        self.telLabel.text = "電話： \(spot.phone)"
        self.telLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(opentimeLabel.snp.bottom).offset(5)
            m.left.equalTo(townLabel).offset(5)
        }
        self.scrollView.addSubview(introductionLabel)
        self.introductionLabel.snp.makeConstraints { (m) in
            m.left.equalTo(telLabel)
            m.top.equalTo(telLabel.snp.bottom).offset(30)
        }
    }
    
    func setupTextView() {
        self.descriptionTextView = UITextView()
        self.scrollView.addSubview(descriptionTextView)
        self.descriptionTextView.sizeToFit() //textview的高，偵測文字的長度
        self.descriptionTextView.isScrollEnabled = false
        self.descriptionTextView.isEditable = false  //不能編輯開關
        
        self.descriptionTextView.font = UIFont.boldSystemFont(ofSize: 18)
        self.descriptionTextView.textColor = .black
        
        self.descriptionTextView.text = """
        \(spot.introduction)
        """
        // spot.description 是簡介，跟 spot.introduction 重複
        self.descriptionTextView.snp.makeConstraints { (m) in
            m.top.equalTo(introductionLabel.snp.bottom).offset(10)
            m.left.equalTo(backgroundImageView).offset(5)
            m.right.equalTo(backgroundImageView).offset(-5)
        }
        self.scrollView.addSubview(travellingLabel)
        self.travellingLabel.snp.makeConstraints { (m) in
            m.left.equalTo(introductionLabel)
            m.top.equalTo(descriptionTextView.snp.bottom).offset(30)
        }
        self.travellinginfoTextView = UITextView()
        self.scrollView.addSubview(travellinginfoTextView)
        self.travellinginfoTextView.sizeToFit() //textview的高，偵測文字的長度
        self.travellinginfoTextView.isScrollEnabled = false
        self.travellinginfoTextView.isEditable = false  //不能編輯開關
        
        self.travellinginfoTextView.font = UIFont.boldSystemFont(ofSize: 18)
        self.travellinginfoTextView.textColor = .black
        
        self.travellinginfoTextView.text = """
        \(spot.travellinginfo)
        """
        self.travellinginfoTextView.snp.makeConstraints { (m) in
            m.left.equalTo(backgroundImageView.snp.left).offset(5)
            m.right.equalTo(backgroundImageView.snp.right).offset(-5)
            m.top.equalTo(travellingLabel.snp.bottom).offset(10)
        }
    }
    
    func setupMapView() {
        self.scrollView.addSubview(mapLabel)
        self.mapLabel.snp.makeConstraints { (m) in
            m.left.equalTo(travellingLabel)
            m.top.equalTo(travellinginfoTextView.snp.bottom).offset(50)
        }
        self.mapView = MKMapView()
        self.scrollView.addSubview(mapView)
        self.mapView.delegate = self
        self.mapView.mapType = .standard
        
        let mapPoint = MKPointAnnotation() 
        mapPoint.title = "\(spot.name)"
        mapPoint.coordinate = CLLocationCoordinate2D(latitude: spot.py, longitude: spot.px)
        self.mapView.addAnnotation(mapPoint)
        self.mapView.region = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: spot.py, longitude: spot.px), latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        self.mapView.snp.makeConstraints { (m) in
            m.width.height.equalTo(400)
            m.top.equalTo(mapLabel.snp.bottom).offset(10)
            m.centerX.equalToSuperview()
        }
        
    }
    
}


extension SpotDetailViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        view.endEditing(true)
    }
}
