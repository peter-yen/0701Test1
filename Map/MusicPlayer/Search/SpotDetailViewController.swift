//
//  SpotDetailViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/28.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit

class SpotDetailViewController: UIViewController {
    var spot: Spot!
    var spaceImageView: UIImageView!
    var tripTextView: UITextView!
    var addLabel: UILabel!
    var townLabel: UILabel!
    var telLabel: UILabel!
    var opentimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = spot.name
        setupSpaceImageView()
        setupLabel()
        setupText()
        
    }
    
    func setupSpaceImageView() {
        spaceImageView = UIImageView()
        view.addSubview(spaceImageView)
        spaceImageView.backgroundColor = .red
        spaceImageView.contentMode = .scaleAspectFill
        spaceImageView.clipsToBounds = true
        spaceImageView.image = UIImage(named: spot.picture1)
        spaceImageView.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            m.width.equalToSuperview()
            m.height.equalTo(250)
            m.centerX.equalToSuperview()
            
        }
    }
    
    func setupLabel() {
        townLabel = UILabel()
        view.addSubview(townLabel)
        townLabel.text = "台灣 \(spot.town)"
        townLabel.textColor = .black
        townLabel.font = UIFont.boldSystemFont(ofSize: 14)
        townLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(spaceImageView.snp.bottom)
            m.left.equalTo(spaceImageView.snp.left)
        }
        addLabel = UILabel()
        view.addSubview(addLabel)
        addLabel.text = "地址： \(spot.add)"
        addLabel.textColor = .black
        addLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(townLabel.snp.bottom)
            m.left.equalTo(townLabel)
        }
        opentimeLabel = UILabel()
        view.addSubview(opentimeLabel)
        opentimeLabel.text = "開放時間： \(spot.opentime)"
        opentimeLabel.textColor = .black
        opentimeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        opentimeLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(addLabel.snp.bottom)
            m.left.equalTo(townLabel)
        }
        telLabel = UILabel()
        view.addSubview(telLabel)
        telLabel.text = "電話： \(spot.tel)"
        telLabel.textColor = .black
        telLabel.font = UIFont.boldSystemFont(ofSize: 14)
        telLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(opentimeLabel.snp.bottom)
            m.left.equalTo(townLabel)
        }
    }
    
    func setupText() {
        tripTextView = UITextView()
        view.addSubview(tripTextView)
        tripTextView.backgroundColor = .systemGray3
        tripTextView.text = """
        景點介紹： \(spot.toldescribe)
        
        \(spot.description)
        
        交通資訊： \(spot.travellinginfo)
        
        """
        
        tripTextView.snp.makeConstraints { (m) in
            m.top.equalTo(telLabel.snp.bottom)
            m.left.equalTo(spaceImageView).offset(5)
            m.right.equalTo(spaceImageView).offset(-5)
            m.bottom.equalToSuperview()
            
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
