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
    var seconds: Int = 60
    var timer = Timer()
    
//MARK: IBOutlets
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var cancelTimerButton: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var songView: UIView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var pickersView: UIView!
    @IBOutlet weak var noSongLabel: UILabel! //label that will show if user did not pick any song
    @IBOutlet weak var noSongSelectedLabel: UILabel! //the no song selected label
    
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSongView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toSongIdentifier":
            guard let vc = segue.destination as? SongsVC else { return }
            vc.isEditingSong = true
        default:
            break
        }
    }
    
//MARK: Private Methods
    private func toEditSong() {
        performSegue(withIdentifier: "toSongIdentifier", sender: true)
    }
    
    private func toEditRequest() {
        navigationController?.popViewController(animated: true)
    }
    
    private func updateTimerViews() {
        if !didStartTimer { //start timer
            startTimer()
        } else { //stopTimer
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true) //start timer
        timerButton.setTitle("Stop Timer", for: .normal)
        timerLabel.text = "Time Left"
        pickersView.isHidden = true
        timeLeftLabel.isHidden = false
        requestTextView.isUserInteractionEnabled = false
        songView.isUserInteractionEnabled = false
        noSongLabel.isUserInteractionEnabled = false
        backButton.isEnabled = false
        didStartTimer = true
    }
    
    private func stopTimer() {
        timer.invalidate() //stop timer
        timerButton.setTitle("Start Timer", for: .normal)
        timerLabel.text = "Set Timer"
        pickersView.isHidden = false
        timeLeftLabel.isHidden = true
        requestTextView.isUserInteractionEnabled = true
        songView.isUserInteractionEnabled = true
        noSongLabel.isUserInteractionEnabled = true
        backButton.isEnabled = true
        didStartTimer = false
    }
    
    private func setupViews() {
        songView.isUserInteractionEnabled = true
        noSongLabel.isUserInteractionEnabled = true
        timeLeftLabel.isHidden = true
        timeLeftLabel.textColor = kMAINCOLOR
        timerButton.backgroundColor = kMAINCOLOR
        setupRequestTextView()
    }
    
    private func setupRequestTextView() {
        requestTextView.isEditable = false
        let toRequestTap = UITapGestureRecognizer(target: self, action: #selector(toRequestTap(_:)))
        self.requestTextView.addGestureRecognizer(toRequestTap)
    }
    
    private func setupSongView() {
        let toSongsTap = UITapGestureRecognizer(target: self, action: #selector(toSongsTap(_:)))
        if let song = Song.currentSong() {
            songView.isHidden = false
            songView.addGestureRecognizer(toSongsTap)
            noSongLabel.isHidden = true
            noSongSelectedLabel.isHidden = true
            songTitleLabel.text = song.songTitle
            songArtistLabel.text = song.songArtist
            songImageView.image = song.songImage
        } else {
            noSongLabel.isHidden = false
            noSongLabel.addGestureRecognizer(toSongsTap)
            noSongSelectedLabel.isHidden = false
            songView.isHidden = true
        }
    }
    
//MARK: IBActions
    
    @IBAction func cancelTimerButtonTapped(_ sender: Any) {
        print("CANCEL")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        updateTimerViews()
    }
    
//MARK: Helpers
    @objc func updateTimer() {
        seconds -= 1
        timeLeftLabel.text = "\(seconds)"
    }
    
    @objc func toSongsTap(_ gesture: UITapGestureRecognizer) {
        toEditSong()
    }
    
    @objc func toRequestTap(_ gesture: UITapGestureRecognizer) {
        toEditRequest()
    }
}
