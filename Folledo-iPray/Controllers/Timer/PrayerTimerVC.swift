//
//  PrayerTimerVC.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/15/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit
import AVFoundation

class PrayerTimerVC: UIViewController {

//MARK: Properties
    var song: Song?
    var songPlayer: AVAudioPlayer?
    var didStartTimer: Bool = false
    var didResumeTimer = false
    var timer = Timer()
    var secondsPickerValues: [Int] = [Int]()
    var minutesPickerValues: [Int] = [Int]()
    var hoursPickerValues: [Int] = [Int]()
    var seconds: Int = 0
    var setTime: (hours: Int, minutes: Int, seconds: Int) = (0,0,0)
    
//MARK: IBOutlets
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var resetTimerButton: UIButton!
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
        requestTextView.text = UserDefaults.standard.string(forKey: kCURRENTPRAYERREQUEST) //load the text frm kCURRENTPRAYERREQUEST
        setupSongView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        songPlayer?.stop()
    }
    
//MARK: Navigation
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
    fileprivate func toEditSong() {
        performSegue(withIdentifier: "toSongIdentifier", sender: true)
    }
    
    fileprivate func toEditRequest() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func updateTimerViews() {
        if !didStartTimer { //start timer
            startTimer()
        } else { //stopTimer
            pauseTimer()
        }
    }
    
    fileprivate func startTimer() {
        if !didResumeTimer { //checks if we have started the timer before, if not then add the setTime to seconds
            seconds += setTime.seconds
            seconds += setTime.minutes * 60
            seconds += setTime.hours * 3600
            didResumeTimer = true
        }
        playSong()
        timeLeftLabel.text = timeString(time: TimeInterval(seconds))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true) //start timer
        timerButton.setTitle("Pause", for: .normal)
        timerLabel.text = "Time Left"
        pickersView.isHidden = true
        timeLeftLabel.isHidden = false
        requestTextView.isUserInteractionEnabled = false
        songView.isUserInteractionEnabled = false
        noSongLabel.isUserInteractionEnabled = false
        backButton.isEnabled = false
        didStartTimer = true
    }
    
    fileprivate func pauseTimer() {
        songPlayer?.pause() //just pause the song
        timer.invalidate() //stop timer
        timerButton.setTitle("Start", for: .normal)
        requestTextView.isUserInteractionEnabled = true
        songView.isUserInteractionEnabled = true
        noSongLabel.isUserInteractionEnabled = true
        backButton.isEnabled = true
        didStartTimer = false
    }
    
    fileprivate func resetTimer() {
        songPlayer?.stop() //stop song
        timer.invalidate() //stop timer
        seconds = 0
        didResumeTimer = false
        timeLeftLabel.textColor = kMAINCOLOR
        timeLeftLabel.text = timeString(time: TimeInterval(seconds))
        timerButton.setTitle("Start", for: .normal)
        timerLabel.text = "Set Timer"
        pickersView.isHidden = false
        timeLeftLabel.isHidden = true
        requestTextView.isUserInteractionEnabled = true
        songView.isUserInteractionEnabled = true
        noSongLabel.isUserInteractionEnabled = true
        backButton.isEnabled = true
        didStartTimer = false
    }
    
    fileprivate func timeString(time:TimeInterval) -> String { //method that will take a timer interval or int and return a string with the formatted time, which the updateTimer objc method will call
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
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
    
    fileprivate func setupViews() {
        songView.isUserInteractionEnabled = true
        noSongLabel.isUserInteractionEnabled = true
        timeLeftLabel.isHidden = true
        timeLeftLabel.textColor = kMAINCOLOR
        timerButton.backgroundColor = kMAINCOLOR
        setupPickers()
        setupRequestTextView()
    }
    
    fileprivate func setupPickers() {
        secondsPicker.delegate = self
        secondsPicker.dataSource = self
        minutesPicker.delegate = self
        minutesPicker.dataSource = self
        hoursPicker.delegate = self
        hoursPicker.dataSource = self
        for x in 0..<60 { //populate the values inside the pickers
            secondsPickerValues.append(x)
            minutesPickerValues.append(x)
            if x < 24 {
                hoursPickerValues.append(x)
            }
        }
        
    }
    
    fileprivate func setupRequestTextView() {
        requestTextView.isEditable = false
        let toRequestTap = UITapGestureRecognizer(target: self, action: #selector(toRequestTap(_:)))
        self.requestTextView.addGestureRecognizer(toRequestTap)
    }
    
    fileprivate func setupSongView() {
        self.song = Song.currentSong()
        let toSongsTap = UITapGestureRecognizer(target: self, action: #selector(toSongsTap(_:)))
        if let song = song {
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
    
    @IBAction func resetTimerButtonTapped(_ sender: UIButton) {
        resetTimer()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func timerButtonTapped(_ sender: UIButton) {
        updateTimerViews()
    }
    
//MARK: Helpers
    @objc func updateTimer() {
        if seconds < 1 {
            songPlayer?.stop()
            timeLeftLabel.textColor = .red
        } else {
//            seconds -= 1
//            timeLeftLabel.text = timeString(time: TimeInterval(seconds))
        }
        seconds -= 1
        timeLeftLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    @objc func toSongsTap(_ gesture: UITapGestureRecognizer) {
        toEditSong()
    }
    
    @objc func toRequestTap(_ gesture: UITapGestureRecognizer) {
        toEditRequest()
    }
}

//MARK: UIPickerView extension
extension PrayerTimerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { //number of components
//        return pickerData[component][row]
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //number of rows
        switch pickerView {
        case secondsPicker:
            return secondsPickerValues.count
        case minutesPicker:
            return minutesPickerValues.count
        case hoursPicker:
            return hoursPickerValues.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //populate the text
        switch pickerView {
        case secondsPicker:
            return String(secondsPickerValues[row])
        case minutesPicker:
            return String(minutesPickerValues[row])
        case hoursPicker:
            return String(hoursPickerValues[row])
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case secondsPicker:
            setTime.seconds = secondsPickerValues[row]
        case minutesPicker:
            setTime.minutes = minutesPickerValues[row]
        case hoursPicker:
            setTime.hours = hoursPickerValues[row]
        default:
            seconds = 0
        }
    }
}
