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
    var backgroundImageView: UIImageView!
    var descriptionTextView: UITextView!
    var addressLabel: UILabel!
    var townLabel: UILabel!
    var telLabel: UILabel!
    var opentimeLabel: UILabel!
    var introductionLabel: UILabel!
    var travellingLabel: UILabel!
    var travellinginfoTextView: UITextView!
    var mapView: MKMapView!
    var scrollView: UIScrollView! //UIScrollView 是可以垂直滑動的一種View
    var mapLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = spot.name
        
        // 從 FavoriteSpotsViewController 點進去 Title spot.name 抓不到
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //設置Title滑動後的效果
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        //上面設置title的顏色和大小
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        scrollView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        setupSpaceImageView()
        setupLabel()
        setupTextView()
        setupMapView()
        
        
    }
    
    func setupSpaceImageView() {
        backgroundImageView = UIImageView()
        scrollView.addSubview(backgroundImageView)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        let url = URL(string: spot.picture1)
        backgroundImageView.sd_setImage(with: url, completed: nil)
        backgroundImageView.snp.makeConstraints { (m) in
            m.top.equalTo(scrollView.snp.top)
            m.width.equalToSuperview()
            m.height.equalTo(250)
            m.centerX.equalToSuperview()
            
        }
    }
    
    func setupLabel() {
        townLabel = UILabel()
        scrollView.addSubview(townLabel)
        townLabel.text = " 台灣 \(spot.district)"
        townLabel.font = UIFont.boldSystemFont(ofSize: 20)
        townLabel.textColor = .systemBlue
        townLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(backgroundImageView.snp.bottom)
            m.left.equalTo(backgroundImageView.snp.left).offset(5)
        }
        addressLabel = UILabel()
        scrollView.addSubview(addressLabel)
        addressLabel.text = "地址： \(spot.address)"
        addressLabel.font = UIFont.boldSystemFont(ofSize: 18)
        addressLabel.textColor = .systemBlue
        addressLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(townLabel.snp.bottom).offset(5)
            m.left.equalTo(townLabel).offset(5)
        }
        opentimeLabel = UILabel()
        scrollView.addSubview(opentimeLabel)
        opentimeLabel.text = "開放時間： \(spot.opentime)"
        opentimeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        opentimeLabel.textColor = .systemBlue
        opentimeLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(addressLabel.snp.bottom).offset(5)
            m.left.equalTo(townLabel).offset(5)
        }
        telLabel = UILabel()
        scrollView.addSubview(telLabel)
        telLabel.text = "電話： \(spot.phone)"
        telLabel.font = UIFont.boldSystemFont(ofSize: 18)
        telLabel.textColor = .systemBlue
        telLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(opentimeLabel.snp.bottom).offset(5)
            m.left.equalTo(townLabel).offset(5)
        }
        introductionLabel = UILabel()
        scrollView.addSubview(introductionLabel)
        introductionLabel.text = "- 景點介紹 -"
        introductionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        introductionLabel.textColor = .systemIndigo
        introductionLabel.snp.makeConstraints { (m) in
            m.left.equalTo(telLabel)
            m.top.equalTo(telLabel.snp.bottom).offset(30)
        }
    }
    
    func setupTextView() {
        descriptionTextView = UITextView()
        scrollView.addSubview(descriptionTextView)
        descriptionTextView.sizeToFit() //textview的高，偵測文字的長度
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false  //不能編輯開關
        
        descriptionTextView.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionTextView.textColor = .black
        
        descriptionTextView.text = """
        \(spot.introduction)
        """
        // spot.description 是簡介，跟 spot.introduction 重複
        descriptionTextView.snp.makeConstraints { (m) in
            m.top.equalTo(introductionLabel.snp.bottom).offset(10)
            m.left.equalTo(backgroundImageView).offset(5)
            m.right.equalTo(backgroundImageView).offset(-5)
        }
        travellingLabel = UILabel()
        scrollView.addSubview(travellingLabel)
        travellingLabel.font = UIFont.boldSystemFont(ofSize: 18)
        travellingLabel.textColor = .systemIndigo
        travellingLabel.text = "- 交通資訊 -"
        travellingLabel.snp.makeConstraints { (m) in
            m.left.equalTo(introductionLabel)
            m.top.equalTo(descriptionTextView.snp.bottom).offset(30)
        }
        travellinginfoTextView = UITextView()
        scrollView.addSubview(travellinginfoTextView)
        travellinginfoTextView.sizeToFit() //textview的高，偵測文字的長度
        travellinginfoTextView.isScrollEnabled = false
        travellinginfoTextView.isEditable = false  //不能編輯開關
        
        travellinginfoTextView.font = UIFont.boldSystemFont(ofSize: 18)
        travellinginfoTextView.textColor = .black
        
        travellinginfoTextView.text = """
        \(spot.travellinginfo)
        """
        travellinginfoTextView.snp.makeConstraints { (m) in
            m.left.equalTo(backgroundImageView.snp.left).offset(5)
            m.right.equalTo(backgroundImageView.snp.right).offset(-5)
            m.top.equalTo(travellingLabel.snp.bottom).offset(10)
        }
    }
    
    func setupMapView() {
        mapLabel = UILabel()
        scrollView.addSubview(mapLabel)
        mapLabel.font = UIFont.boldSystemFont(ofSize: 18)
        mapLabel.text = "- 地圖資訊 -"
        mapLabel.textColor = .systemIndigo
        mapLabel.snp.makeConstraints { (m) in
            m.left.equalTo(travellingLabel)
            m.top.equalTo(travellinginfoTextView.snp.bottom).offset(50)
        }
        mapView = MKMapView()
        scrollView.addSubview(mapView)
        mapView.delegate = self
        mapView.mapType = .standard
        
        let mapPoint = MKPointAnnotation() 
        mapPoint.title = "\(spot.name)"
        mapPoint.coordinate = CLLocationCoordinate2D(latitude: spot.py, longitude: spot.px)
        mapView.addAnnotation(mapPoint)
        mapView.region = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: spot.py, longitude: spot.px), latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.snp.makeConstraints { (m) in
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
