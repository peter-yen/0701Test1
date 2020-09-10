//
//  MapViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/10.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class MapViewController: UIViewController {
    var spot: [Spot] = []
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupLocationManager()
        
        Firestore.firestore().collection("Spots").getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            
            if let snapshot = snapshot?.documents {
                for spotIds in snapshot {
                    if let dict = spotIds.data() as? [String: Any] {
                        
                        print(dict)
                    }
                }
            }
            
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
            let alertController = UIAlertController(title: "嗨！你好", message: "給林北同意定位", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "去射", style: .default) { (_) in
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
    
    
    func setupMapView() {
        mapView = MKMapView()
        view.addSubview(mapView)
        mapView.showsUserLocation = true
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
        
    }
    


}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        
        guard let coordinate = locations.last?.coordinate else { return }
        let degrees = CLLocationDegrees(0.01)
        let span = MKCoordinateSpan(latitudeDelta: degrees, longitudeDelta: degrees)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
}
 
