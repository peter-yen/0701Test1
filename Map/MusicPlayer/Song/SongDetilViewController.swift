//
//  SongDetilViewController.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/18.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class SongDetilViewController: UIViewController {
    var songTitleLabel: UILabel!
    var lyricTextView: UITextView!
    var singerImageView: UIImageView!
    var playButton: UIButton!
    var player: AVAudioPlayer?

    
    
    var songTitle: String = ""
    var songText: String = ""
    var singerImageTitle: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        
        songTitleLabel = UILabel()
        view.addSubview(songTitleLabel)
        songTitleLabel.textColor = .white
        songTitleLabel.text = songTitle
        songTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        songTitleLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(15)
        }
        
        
        lyricTextView = UITextView()
        view.addSubview(lyricTextView)
        lyricTextView.backgroundColor = .systemGray
        lyricTextView.textColor = .cyan
        lyricTextView.font = UIFont.boldSystemFont(ofSize: 20)
        lyricTextView.text = songText
        lyricTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(songTitleLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
        singerImageView = UIImageView()
        view.addSubview(singerImageView)
        singerImageView.image = UIImage(named: singerImageTitle)
        singerImageView.backgroundColor = .white
        
        singerImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(20)
        }
        playButton = UIButton()
        view.addSubview(playButton)
        playButton.backgroundColor = .white
        playButton.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.centerY.equalTo(singerImageView.snp.centerY)
            make.leading.equalTo(singerImageView.snp.trailing).offset(50)
        }
        
        playButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        let playImage = UIImage(named: "play")
        playButton.setImage(playImage, for: .normal)
        let pauseImage = UIImage(named: "pause")
        playButton.setImage(pauseImage, for: .selected)
        
        
        
        
        setupMP3Player()
        
    }
    func setupMP3Player() {
          print("start playing mp3")
          guard let url = Bundle.main.url(forResource: "Jay", withExtension: "mp3") else { return }

          do {
              try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
              try AVAudioSession.sharedInstance().setActive(true)

              player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

              

          } catch let error {
              print(error.localizedDescription)
          }
    }
    
    @objc func playSound() {
        if playButton.isSelected == true {
            print("pause Mp3")
            playButton.isSelected = false
            player?.pause()
        }else if playButton.isSelected == false {
            print("play Mp3")
            playButton.isSelected = true
            player?.play()
        }
        
    }
    
   
    }
    
    

   
