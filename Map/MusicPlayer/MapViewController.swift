//
//  MapViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/10.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import FirebaseFirestore

class MapViewController: UIViewController {
    var spots: [Spot] = []
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var searchView: UIView!
    var gestureView: UIView!
    var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLocationManager()
        setupSearchView()
        setupGestureView()
        setupDismissButton()
        
        
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
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            m.trailing.equalToSuperview().offset(-10)
            m.leading.equalToSuperview().offset(10)
            m.height.equalTo(40)
        }
    }
    
    func setupGestureView() {
        gestureView = UIView()
        view.addSubview(gestureView)
        gestureView.backgroundColor = .yellow
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        pan.minimumNumberOfTouches = 1   // 最少幾根手指觸發
        pan.maximumNumberOfTouches = 1   // 最多幾根手指觸發
        let translation = pan.translation(in: gestureView)
        
        gestureView.addGestureRecognizer(pan)
        gestureView.isUserInteractionEnabled = true // 觸控開關
        
        gestureView.snp.makeConstraints { (m) in
            m.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(150)
            m.height.equalTo(200)
            m.trailing.leading.equalToSuperview()
        }
    }

    @objc func panGestureAction(sender: UIPanGestureRecognizer) {
        if let panView = gestureView {
            view.addSubview(panView)
            panView.backgroundColor = .red
            panView.snp.makeConstraints { (m) in
                m.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                           m.height.equalTo(200)
                           m.trailing.leading.equalToSuperview()
                
                if let returnButton = dismissButton {
                    returnButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
                }
            }
            
        }

    }
    
    func setupDismissButton() {
        dismissButton = UIButton()
        view.addSubview(dismissButton)
        let buttonImage = UIImage(named: "return")
        dismissButton.setImage(buttonImage, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        dismissButton.isEnabled = true
        dismissButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(40)
            m.trailing.equalTo(view.snp.trailing).offset(-10)
            m.bottom.equalTo(gestureView.snp.top).offset(-25)
        }
    }
    @objc func dismissButtonDidTap() {
        print("sdsd")
        if let returnView = gestureView {
            returnView.snp.makeConstraints { (m) in
        m.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(150)
                   m.height.equalTo(200)
                   m.trailing.leading.equalToSuperview()
            }
        }
        
    }
    
    
    
    
    
}


extension MapViewController: CLLocationManagerDelegate {
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


extension MapViewController: MKMapViewDelegate {
    
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
