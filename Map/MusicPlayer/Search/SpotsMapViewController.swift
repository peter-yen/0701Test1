//
//  SpotsMapViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/16.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import FirebaseFirestore

class SpotsMapViewController: UIViewController {
    var spots: [Spot] = []
    var spot: Spot!
    var mapView: MKMapView = {
        let mv = MKMapView()
        mv.showsUserLocation = true
        return mv
    }()
    var locationManager: CLLocationManager!
    lazy var searchView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .white
        sv.clipsToBounds = true
        sv.layer.cornerRadius = 15
        return sv
    }()
    var spotDetailsView: UIView!
    var myLocationButton: UIButton!
    var spotDetailTopAnchor: NSLayoutConstraint!
    lazy var touchView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .white
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 3
        return tv
    }()
    lazy  var nameLabel: UILabel = {
        let nl = UILabel()
        nl.textAlignment = .center
        nl.font = UIFont.boldSystemFont(ofSize: 19)
        nl.text = ""
        return nl
    }()
    lazy var addressLabel: UILabel = {
        let al = UILabel()
        al.text = ""
        al.font = UIFont.boldSystemFont(ofSize: 18)
        return al
    }()
    lazy var phoneLabel: UILabel = {
        let pl = UILabel()
        pl.text = ""
        pl.font = UIFont.systemFont(ofSize: 18)
        return pl
    }()
    lazy var openLabel: UILabel = {
        let ol = UILabel()
        ol.text = ""
        ol.font = UIFont.systemFont(ofSize: 18)
        return ol
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLocationManager()
        setupSearchView()
        setupSpotDetailsView()
        setupLocationButton()
        setupTouchView()
        
        
        Firestore.firestore().collection("Spots").getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            if let snapshots = snapshot?.documents {
                for snapshot in snapshots {
                    let dict = snapshot.data()
                    let spotArray = Spot(firestoreDictionary: dict)
                    self.spots.append(spotArray)
                    
                }
            }
            self.addAnnotation(spots: self.spots)
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied :
            let alertController = UIAlertController(title: "嗨！你好", message: "同意定位", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "去設定", style: .default) { (_) in
                if let url = URL.init(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            alertController.addAction(action)
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        case.notDetermined :
            self.locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        
    }
    
    func addAnnotation(spots: [Spot]) {
        for spot in spots {
            let mapPoint = SpotAnnotation(spot: spot)
            self.mapView.addAnnotation(mapPoint)
            
        }
    }
    
    
    func setupMapView() {
        view.addSubview(mapView)
        self.mapView.delegate = self
        self.mapView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
    }
    
    func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        self.locationManager.startUpdatingLocation()
        // 一開始進去呼叫自己的位置
        
    }
    
    func setupSearchView() {
        view.addSubview(searchView)
        self.searchView.snp.makeConstraints { (m) in
            //    位置來這裡沒偵測  safeAreaLayoutGuide
            //            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            m.trailing.equalToSuperview().offset(-10)
            m.leading.equalToSuperview().offset(10)
            m.height.equalTo(35)
        }
    }
    
    func setupSpotDetailsView() {
        self.spotDetailsView = UIView()
        view.addSubview(spotDetailsView)
        self.spotDetailsView.backgroundColor = .cyan
        self.spotDetailsView.alpha = 0.8
        self.spotDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.spotDetailsView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.spotDetailsView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.spotDetailsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.spotDetailTopAnchor = spotDetailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -130)
        self.spotDetailTopAnchor.isActive = true
        
        self.spotDetailsView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (m) in
            m.top.equalTo(spotDetailsView.snp.top).offset(15)
            m.width.equalToSuperview()
        }
        self.spotDetailsView.addSubview(addressLabel)
        self.addressLabel.snp.makeConstraints { (m) in
            m.top.equalTo(nameLabel.snp.top).offset(35)
            m.width.equalToSuperview()
        }
        self.spotDetailsView.addSubview(phoneLabel)
        self.phoneLabel.snp.makeConstraints { (m) in
            m.top.equalTo(addressLabel.snp.top).offset(30)
            m.width.equalToSuperview()
        }
        self.spotDetailsView.addSubview(openLabel)
        self.openLabel.snp.makeConstraints { (m) in
            m.top.equalTo(phoneLabel.snp.top).offset(30)
            m.width.equalToSuperview()
        }
        let pan = UIPanGestureRecognizer(target: self, action: #selector(spotDetailsViewPanGesture(recognizer:)))
        pan.minimumNumberOfTouches = 1   // 最少幾根手指觸發
        pan.maximumNumberOfTouches = 1   // 最多幾根手指觸發
        self.spotDetailsView.addGestureRecognizer(pan)
        self.spotDetailsView.isUserInteractionEnabled = true // 觸控開關
    }
    
    @objc func spotDetailsViewPanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let contant = self.spotDetailTopAnchor.constant
        
        switch recognizer.state {
        case .changed:
            let constrainAfterTranslation = spotDetailTopAnchor.constant + translation.y
            if constrainAfterTranslation > -250 {
                // 不懂怎麼設無法拉超過 -200
                self.spotDetailTopAnchor.constant = constrainAfterTranslation
                recognizer.setTranslation(.zero, in: self.view)
            }
        case .ended:
            if contant > -155 {
                self.spotDetailTopAnchor.constant = -130
            } else {
                self.spotDetailTopAnchor.constant = -250
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            },completion: nil)
            
        default:
            break
        }
    }
    
    func setupTouchView() {
        self.spotDetailsView.addSubview(touchView)
        self.touchView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(7)
            m.height.equalTo(6)
            m.width.equalTo(150)
            m.centerX.equalToSuperview()
        }
    }
    
    func setupLocationButton() {
        self.myLocationButton = UIButton()
        view.addSubview(myLocationButton)
        self.myLocationButton.backgroundColor = .white
        self.myLocationButton.clipsToBounds = true
        self.myLocationButton.layer.cornerRadius = 25
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        // 設置 xcode 原生圖片大小
        let normalImage = UIImage(systemName: "location", withConfiguration: configuration)
        self.myLocationButton.setImage(normalImage, for: .normal)
        let diselectImage = UIImage(systemName: "location.fill", withConfiguration: configuration)
        self.myLocationButton.setImage(diselectImage, for: .selected)
        self.myLocationButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        self.myLocationButton.isEnabled = true
        
        self.myLocationButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(50)
            m.trailing.equalTo(view.snp.trailing).offset(-10)
            m.bottom.equalTo(spotDetailsView.snp.top).offset(-25)
        }
    }
    @objc func dismissButtonDidTap() {
        
        self.locationManager.startUpdatingLocation()
        //  按下去後回到自己的位置
        
    }
    
}


extension SpotsMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationManager.stopUpdatingLocation()
        //  不持續, 並停止呼叫自己的位置
        
        guard let coordinate = locations.last?.coordinate else { return }
        let degrees = CLLocationDegrees(0.01)
        let span = MKCoordinateSpan(latitudeDelta: degrees, longitudeDelta: degrees)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        self.myLocationButton.isSelected = true
    }
}


extension SpotsMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.myLocationButton.isSelected = false
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? SpotAnnotation {
            let degrees = CLLocationDegrees(0.01)
            let span = MKCoordinateSpan(latitudeDelta: degrees, longitudeDelta: degrees)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            // 點擊移動到標記地點 , 固定縮放大小
            self.spot = annotation.spot
            
            self.nameLabel.text = "\(spot.name)"
            self.addressLabel.text = "地址: \(spot.address)"
            self.phoneLabel.text = "電話: \(spot.phone)"
            self.openLabel.text = "開放時間: \(spot.opentime)"
            
        }
    }
}


class SpotAnnotation: MKPointAnnotation {
    var spot: Spot!
    
    convenience  init(spot: Spot) {
        self.init()
        
        self.spot = spot
        
        let coordinate = CLLocationCoordinate2D(latitude: spot.py, longitude: spot.px)
        self.title = spot.name
        self.coordinate = coordinate
        
        //        let spotsMapViewController = SpotsMapViewController()
        //        spotsMapViewController.spot = spot
    }
    
}
