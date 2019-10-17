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
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
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
        if song!.songArtist == nil || song!.songArtist == "" {
            artistLabel.text = "Unknown Artist"
        } else { artistLabel.text = song!.songArtist }
        if song!.songCategory1 == nil || song!.songCategory1 == "" {
            categoryLabel.text = "Unknown Category"
        } else { categoryLabel.text = song!.songCategory1 }
        if song!.songLength == nil || song!.songLength <= 0 {
            lengthLabel.text = "Unknown Length"
        } else { lengthLabel.text = "\(song!.songLength)" }
    }
    
    fileprivate func playSong() {
        let soundPath = Bundle.main.path(forResource: song!.songPath, ofType:"mp3")!
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
