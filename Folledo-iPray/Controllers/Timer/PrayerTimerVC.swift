//
//  PrayerTimerVC.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/15/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class PrayerTimerVC: UIViewController {

//MARK: Properties
    var song: Song?
    
//MARK: IBOutlets
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    
    @IBOutlet weak var songImageView: UIImageView!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let song = Song.currentSong()
        songImageView.image = song?.songImage
    }
    
    
//MARK: Private Methods
    
//MARK: IBActions
    @IBAction func backButtonTapped(_ sender: Any) {       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func timerButtonTapped(_ sender: Any) {
    
    }
    
//MARK: Helpers

}
