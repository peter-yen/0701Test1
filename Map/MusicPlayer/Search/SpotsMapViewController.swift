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
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var searchView: UIView!
    var spotDetailsView: UIView!
    var dismissButton: UIButton!
    var spotDetailTopAnchor: NSLayoutConstraint!
    var touchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLocationManager()
        setupSearchView()
        setupSpotDetailsView()
        setupDismissButton()
        setupTouchView()
        
        
        Firestore.firestore().collection("Spots").getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            if let snapshots = snapshot?.documents {
                for snapshot in snapshots {
                    let dict = snapshot.data()
                    let spot = Spot(firestoreDictionary: dict)
                    self.spots.append(spot)
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
            locationManager.requestWhenInUseAuthorization()
        case.notDetermined :
            let alertController = UIAlertController(title: "嗨！你好", message: "同意定位", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "去設定", style: .default) { (_) in
                if let url = URL.init(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            alertController.addAction(action)
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        default:
            break
        }
        
    }
    
    func addAnnotation(spots: [Spot]) {
        for spot in spots {
            let mapPoint = SpotAnnotation(spot: spot)
            mapView.addAnnotation(mapPoint)
        }
    }
    
    func setupMapView() {
        mapView = MKMapView()
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        // 一開始進去呼叫
        
    }
    
    func setupSearchView() {
        searchView = UIView()
        view.addSubview(searchView)
        searchView.backgroundColor = .white
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 15
        searchView.snp.makeConstraints { (m) in
            //    位置來這裡沒偵測  safeAreaLayoutGuide
//            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            m.trailing.equalToSuperview().offset(-10)
            m.leading.equalToSuperview().offset(10)
            m.height.equalTo(35)
        }
    }
    
    func setupSpotDetailsView() {
        spotDetailsView = UIView()
        view.addSubview(spotDetailsView)
        spotDetailsView.backgroundColor = .cyan
        spotDetailsView.alpha = 0.8
        spotDetailsView.translatesAutoresizingMaskIntoConstraints = false
        spotDetailsView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        spotDetailsView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        spotDetailsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        spotDetailTopAnchor = spotDetailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -120)
        spotDetailTopAnchor.isActive = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(spotDetailsViewPanGesture(recognizer:)))
        pan.minimumNumberOfTouches = 1   // 最少幾根手指觸發
        pan.maximumNumberOfTouches = 1   // 最多幾根手指觸發
        spotDetailsView.addGestureRecognizer(pan)
        spotDetailsView.isUserInteractionEnabled = true // 觸控開關
    }
    
    @objc func spotDetailsViewPanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let contant = spotDetailTopAnchor.constant
        
        switch recognizer.state {
        case .changed:
            let constrainAfterTranslation = spotDetailTopAnchor.constant + translation.y
            if constrainAfterTranslation > -240 {
                // 不懂怎麼設無法拉超過 -200
                self.spotDetailTopAnchor.constant = constrainAfterTranslation
                recognizer.setTranslation(.zero, in: self.view)
            }
        case .ended:
            if contant > -145 {
                self.spotDetailTopAnchor.constant = -120
            } else {
                self.spotDetailTopAnchor.constant = -240
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            },completion: nil)
            
        default:
            break
        }
    }
    
    func setupTouchView() {
        touchView = UIView()
        spotDetailsView.addSubview(touchView)
        touchView.backgroundColor = .white
        touchView.clipsToBounds = true
        touchView.layer.cornerRadius = 3
        touchView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(8)
            m.height.equalTo(6)
            m.width.equalTo(150)
            m.centerX.equalToSuperview()
        }
    }
    
    func setupDismissButton() {
        dismissButton = UIButton()
        view.addSubview(dismissButton)
        let buttonImage = UIImage(named: "location")
        dismissButton.setImage(buttonImage, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        dismissButton.isEnabled = true
        dismissButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(45)
            m.trailing.equalTo(view.snp.trailing).offset(-10)
            m.bottom.equalTo(spotDetailsView.snp.top).offset(-25)
        }
    }
    @objc func dismissButtonDidTap() {
        
        
    }
    
    
    
    
}


extension SpotsMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        // 呼叫完後就退出呼叫
        
        guard let coordinate = locations.last?.coordinate else { return }
        let degrees = CLLocationDegrees(0.01)
        let span = MKCoordinateSpan(latitudeDelta: degrees, longitudeDelta: degrees)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}


extension SpotsMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? SpotAnnotation {
            let spotDetailViewController = SpotDetailViewController()
            spotDetailViewController.spot = annotation.spot
            present(spotDetailViewController, animated: true, completion: nil)
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
    }
    
}
