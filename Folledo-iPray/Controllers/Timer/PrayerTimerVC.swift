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
    var didStartTimer: Bool = false
    
//MARK: IBOutlets
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var songView: UIView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var pickersView: UIView!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSongView()
    }
    
//MARK: Private Methods
    func updateTimer() {
        if !didStartTimer { //start timer
            timerButton.setTitle("Stop Timer", for: .normal)
            timerLabel.text = "Time Left"
            pickersView.isHidden = true
            timeLeftLabel.isHidden = false
            requestTextView.isUserInteractionEnabled = false
            songView.isUserInteractionEnabled = false
            backButton.isEnabled = false
            didStartTimer = true
        } else { //stop timer
            timerButton.setTitle("Start Timer", for: .normal)
            timerLabel.text = "Set Timer"
            pickersView.isHidden = false
            timeLeftLabel.isHidden = true
            requestTextView.isUserInteractionEnabled = true
            songView.isUserInteractionEnabled = true
            backButton.isEnabled = true
            didStartTimer = false
        }
    }
    
    func setupViews() {
        songView.isUserInteractionEnabled = true
        let toSongsTap = UITapGestureRecognizer(target: self, action: #selector(toSongsTap(_:)))
        self.songView.addGestureRecognizer(toSongsTap)
        timeLeftLabel.isHidden = true
        timeLeftLabel.textColor = kMAINCOLOR
        timerButton.backgroundColor = kMAINCOLOR
        requestTextView.isEditable = false
        let toRequestTap = UITapGestureRecognizer(target: self, action: #selector(toRequestTap(_:)))
        self.requestTextView.addGestureRecognizer(toRequestTap)
    }
    
    func setupSongView() {
        let song = Song.currentSong()
        songTitleLabel.text = song!.songTitle
        songArtistLabel.text = song!.songArtist
        songImageView.image = song!.songImage
        
    }
//MARK: IBActions
    @IBAction func backButtonTapped(_ sender: Any) {       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        updateTimer()
    }
    
//MARK: Helpers
    @objc func toSongsTap(_ gesture: UITapGestureRecognizer) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func toRequestTap(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
