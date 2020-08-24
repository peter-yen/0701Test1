//
//  StepOneViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/18.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

class StepOneViewController: UIViewController {
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var progressBarImageView: UIImageView!
    var nextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        //        emailLabel.backgroundColor = .black
        emailLabel.font = .boldSystemFont(ofSize: 22)
        emailLabel.text = "電子郵件"
        emailLabel.snp.makeConstraints { (m) in
            m.width.equalTo(100)
            m.height.equalTo(30)
            m.leading.equalTo(view.snp.leading).offset(15)
            m.top.equalTo(view.snp.top).offset(85)
        }
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        //        emailTextField.backgroundColor = .systemGray2
        emailTextField.placeholder = "請輸入電子郵件"
        emailTextField.snp.makeConstraints { (m) in
            m.height.equalTo(50)
            m.width.equalTo(390)
            m.centerX.equalToSuperview()
            m.top.equalTo(emailLabel.snp.bottom).offset(10)
        }
        
        nextStepButton = UIButton()
        view.addSubview(nextStepButton)
        nextStepButton.backgroundColor = .systemRed
        nextStepButton.setTitle("下一步", for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStepButtonDidTap), for: .touchUpInside)
        nextStepButton.snp.makeConstraints { (m) in
            m.width.equalTo(250)
            m.height.equalTo(50)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
        
        progressBarImageView = UIImageView()
        view.addSubview(progressBarImageView)
        progressBarImageView.backgroundColor = .systemGray2
        progressBarImageView.snp.makeConstraints { (m) in
            m.width.equalTo(300)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.top.equalTo(nextStepButton.snp.bottom).offset(15)
        }
        
        
    }
    @objc func nextStepButtonDidTap() {
        let stepTwoViewController = StepTwoViewController()
//        var email = emailTextField.text
        self.navigationController?.pushViewController(stepTwoViewController, animated: true)
        
        
    
    }

}

extension StepOneViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
