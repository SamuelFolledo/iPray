//
//  Song.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/15/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class Song {
    let songID: String?
    let songTitle: String?//title
    let songName: String? //name of the song with extension
    let songImage: UIImage?
    let songURL: String = ""
    let songLength: Float = 0.0
    let songCategory1: String = ""
    let songCategory2: String = ""
    
    init(songID: String, songTitle: String, songName: String, image: UIImage = UIImage(named: "SFLogo")!) {
        self.songID = songID
        self.songTitle = songTitle
        self.songName = songName
        self.songImage = image
    }
    
}
