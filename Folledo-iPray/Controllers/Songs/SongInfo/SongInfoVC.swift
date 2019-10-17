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
        setupView()
        playSong()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        songPlayer?.stop()
    }
    
    
//MARK: Private Methods
    fileprivate func setupView() {
        self.title = song!.songTitle
        songImageView.image = song!.songImage
        artistLabel.text = song!.songTitle
    }
    
    fileprivate func playSong() {
        let soundPath = Bundle.main.path(forResource: song!.songName, ofType:"mp3")!
        let url = URL(fileURLWithPath: soundPath)
        do {
            songPlayer = try AVAudioPlayer(contentsOf: url)
            songPlayer?.play()
        } catch {
            print("Couldn't load file = \(error)")
        }
    }
//MARK: IBActions
    
//MARK: Helpers

}
