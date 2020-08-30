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
    var backgroundImageView: UIImageView!
    var descriptionTextView: UITextView!
    var addressLabel: UILabel!
    var townLabel: UILabel!
    var telLabel: UILabel!
    var opentimeLabel: UILabel!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = spot.name
        navigationController?.navigationBar.prefersLargeTitles = true
        //設置Title滑動後的效果
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cyan,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
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
        setupText()
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
        townLabel.text = "台灣 \(spot.town)"
        townLabel.font = UIFont.boldSystemFont(ofSize: 20)
        townLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(backgroundImageView.snp.bottom)
            m.left.equalTo(backgroundImageView.snp.left)
        }
        addressLabel = UILabel()
        scrollView.addSubview(addressLabel)
        addressLabel.text = "地址： \(spot.add)"
        addressLabel.font = UIFont.boldSystemFont(ofSize: 17)
        addressLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(townLabel.snp.bottom)
            m.left.equalTo(townLabel)
        }
        opentimeLabel = UILabel()
        scrollView.addSubview(opentimeLabel)
        opentimeLabel.text = "開放時間： \(spot.opentime)"
        opentimeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        opentimeLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(addressLabel.snp.bottom)
            m.left.equalTo(townLabel)
        }
        telLabel = UILabel()
        scrollView.addSubview(telLabel)
        telLabel.text = "電話： \(spot.tel)"
        telLabel.font = UIFont.boldSystemFont(ofSize: 17)
        telLabel.snp.makeConstraints { (m) in
            m.width.equalToSuperview()
            m.top.equalTo(opentimeLabel.snp.bottom)
            m.left.equalTo(townLabel)
        }
    }
    
    func setupText() {
        descriptionTextView = UITextView()
        scrollView.addSubview(descriptionTextView)
        descriptionTextView.sizeToFit() //textview的高，偵測文字的長度
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false  //不能編輯開關
        descriptionTextView.backgroundColor = .systemGray3
        descriptionTextView.text = """
        景點介紹： \(spot.toldescribe)
        
        \(spot.description)
        
        交通資訊： \(spot.travellinginfo)
        
        """
        
        descriptionTextView.snp.makeConstraints { (m) in
            m.top.equalTo(telLabel.snp.bottom)
            m.left.equalTo(backgroundImageView).offset(5)
            m.right.equalTo(backgroundImageView).offset(-5)
            
            
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
