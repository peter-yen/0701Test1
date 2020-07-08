//
//  MapViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mapview = MKMapView()
        view.addSubview(mapview)
        mapview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        
    }
    

    }

}
