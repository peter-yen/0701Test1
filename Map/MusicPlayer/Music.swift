//
//  Music.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/7.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation
class Music {
    var singer: String
    var song: String
    var imangeArray: String
    var lyric: String
    init(singer: String, song: String, imangeArray: String, lyric: String) {
        self.singer = singer
        self.song = song
        self.imangeArray = imangeArray
        self.lyric = lyric
        
    }
}
