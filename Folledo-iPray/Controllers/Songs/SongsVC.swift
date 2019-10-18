//
//  SongsVC.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/15/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class SongsVC: UIViewController {

//MARK: Properties
    var songs: [Song] = [Song]()
    let cellID: String = "songCellID"
    var isEditingSong: Bool = false
//    var currentSongId: Int?
    
//MARK: IBOutlets
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.backgroundColor = kMAINCOLOR
        createDataCell()
        songsTableView.tableFooterView = UIView() //remove the additional line separator underneath our products
        
//        NotificationCenter.default.addObserver(self, selector: #selector(timerTrigger), name: NSNotification.Name(rawValue: "timerStarted"), object: nil) //subscribe to the noticiation
    }
    
//MARK: Private Methods
    func createDataCell() {
        let song0 = Song.init(songID: "0", songTitle: "Living Hope", songArtist: "Phil Wickham", songPath: "livingHope", image: UIImage(named: "livingHope.png")!)
        let song1 = Song.init(songID: "1", songTitle: "Give Me Faith", songArtist: "Elevation Worship", songPath: "giveMeFaith-ElevationWorship", image: UIImage(named: "giveMeFaith.jpeg")!)
        let song2 = Song.init(songID: "2", songTitle: "No Longer Slaves", songArtist: "Bethel Music", songPath: "noLongerSlaves-BethelMusic", image: UIImage(named: "noLongerSlaves.jpg")!)
        let song3 = Song.init(songID: "3", songTitle: "No One Higher", songArtist: "Aaron Shust", songPath: "noOneHigher-AaronShust", image: UIImage(named: "noOneHigher.png")!)
        let song4 = Song.init(songID: "4", songTitle: "Oceans (long version)", songArtist: "Hillsong", songPath: "oceans(long)-Hillsong", image: UIImage(named: "oceans(long).png")!)
        let song5 = Song.init(songID: "5", songTitle: "Reckless Love", songArtist: "Cory Asbury", songPath: "recklessLove-Bethel", image: UIImage(named: "recklessLove.png")!)
        let song6 = Song.init(songID: "6", songTitle: "Oceans (shorter version)", songArtist: "Hillsong", songPath: "oceans(long)-Hillsong", image: UIImage(named: "oceans(short).png")!)
        let song7 = Song.init(songID: "7", songTitle: "Unfailing Love", songArtist: "Chris Tomlin", songPath: "unfailingLove-ChrisTomlin", image: UIImage(named: "unfailingLove.png")!)
        let song8 = Song.init(songID: "8", songTitle: "What A Beautiful Name It Is", songArtist: "Hillsong", songPath: "whatABeautifulNameItIs", image: UIImage(named: "whatABeautifulNameItIs.jpg")!)
        let song9 = Song.init(songID: "9", songTitle: "Who You Say I Am", songArtist: "Hillsong", songPath: "whoYouSayIAm-Hillsong", image: UIImage(named: "whoYouSayIAm.jpg")!)
        self.insertRowWithAnimation(row: 0, song: song0) {
            self.insertRowWithAnimation(row: 1, song: song1) {
                self.insertRowWithAnimation(row: 2, song: song2) {
                    self.insertRowWithAnimation(row: 3, song: song3) {
                        self.insertRowWithAnimation(row: 4, song: song4) {
                            self.insertRowWithAnimation(row: 5, song: song5) {
                                self.insertRowWithAnimation(row: 6, song: song6) {
                                    self.insertRowWithAnimation(row: 7, song: song7) {
                                        self.insertRowWithAnimation(row: 8, song: song8) {
                                            self.insertRowWithAnimation(row: 9, song: song9) {
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
//MARK: IBActions
    @IBAction func doneButtonTapped(_ sender: Any) {
        Song.deleteSong()
        goToNextController()
    }
    
//MARK: Helpers
    func insertRowWithAnimation(row: Int, song: Song, completion: @escaping ()-> Void) { //cell animation
        let indexPath = IndexPath(row: row, section: 0)
        songs.append(song)
        songsTableView.insertRows(at: [indexPath], with: .right) //insert rows from right side in 0.2 secs
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion()
        }
    }
    
    func goToNextController() {
        if isEditingSong { //if we are editing the song from timerVC, then dismiss
//            dismiss(animated: true, completion: nil) //will work for modally, but not for push
            navigationController?.popViewController(animated: true) //this is how you dismiss a push
        } else { //if isEditingSong is false, we are at at home
            performSegue(withIdentifier: "toRequestIdentifier", sender: nil)
        }
    }
    
//MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toRequestIdentifier":
            if let song = sender as? Song {
                print(song.songTitle!)
                if let nav = segue.destination as? UINavigationController,
                    let vc: PrayerRequestVC = nav.topViewController as? PrayerRequestVC {
//                    vc.song = song //since we are saving song to UserDefaults, we don't need this anymore
                    vc.song = Song.currentSong()
                }
            } else {
                print("Skipped! No song is passed")
            }
        case "toSongInfoIdentifier":
            if let song = sender as? Song {
                if let nav = segue.destination as? UINavigationController,
                    let vc: SongInfoVC = nav.topViewController as? SongInfoVC {
                    vc.song = song
                }
            }
        default:
            break
        }
    }
    
//    @objc func timerTrigger(_ notification: Notification) {
//        if let dic = notification.userInfo as? [String: Any] {
//            let songId = dic[kSONGID] as! String
//            print("\(songId) is songid")
//            currentSongId = Int(songId)
//        }
//    }
}

extension SongsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SongCell
        cell.accessoryType = .detailButton //i on the right side of the cell
        cell.song = songs[indexPath.row]
        cell.populateCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        saveSongLocally(song: song) //save our current song the user selected to UserDefauts
//        if let id = currentSongId {
//            if indexPath.row == id {
//                performSegue(withIdentifier: "toSongIdentifier", sender: nil)
//            }
//        }
        
        goToNextController()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let song = songs[indexPath.row]
        performSegue(withIdentifier: "toSongInfoIdentifier", sender: song)
    }
}
