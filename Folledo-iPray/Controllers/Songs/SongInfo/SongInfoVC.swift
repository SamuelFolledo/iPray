//
//  SongInfoVC.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/16/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit
import AVFoundation


class SongInfoVC: UIViewController {

//MARK: Properties
    var song: Song?
    var songPlayer: AVAudioPlayer?
    
//MARK: IBOutlets
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = song!.songTitle
        songImageView.image = song?.songImage
        
        print("SONG NAME IS \(song!.songName)")
        let soundPath = Bundle.main.path(forResource: song!.songName, ofType:"mp3")!
        let url = URL(fileURLWithPath: soundPath)
        do {
            songPlayer = try AVAudioPlayer(contentsOf: url)
            songPlayer?.play()
        } catch {
            print("Couldn't load file = \(error)")
        }
    }
    
    
//MARK: Private Methods
    
//MARK: IBActions
    
//MARK: Helpers

}
