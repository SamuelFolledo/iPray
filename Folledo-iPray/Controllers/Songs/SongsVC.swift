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
    
//MARK: IBOutlets
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataCell()
        songsTableView.tableFooterView = UIView() //remove the additional line separator underneath our products
    }
    
//MARK: Private Methods
    func createDataCell() {
        let song0 = Song.init(songID: "0", songTitle: "Living Hope", songArtist: "Phil Wickham", songPath: "LivingHope")
        let song1 = Song.init(songID: "1", songTitle: "Give Me Faith", songArtist: "Elevation Worship", songPath: "GiveMeFaith-ElevationWorship", image: UIImage(named: "SFLogo")!)
        let song2 = Song.init(songID: "2", songTitle: "No Longer Slaves", songArtist: "Bethel Music", songPath: "NoLongerSlaves-BethelMusic", image: UIImage(named: "SFLogo")!)
        let song3 = Song.init(songID: "3", songTitle: "No One Higher", songArtist: "Aaron Shust", songPath: "NoOneHigher-AaronShust", image: UIImage(named: "SFLogo")!)
        let song4 = Song.init(songID: "4", songTitle: "Oceans (long version)", songArtist: "Hillsong", songPath: "Oceans(long)-Hillsong", image: UIImage(named: "SFLogo")!)
        let song5 = Song.init(songID: "5", songTitle: "Reckless Love", songArtist: "Cory Asbury", songPath: "RecklessLove-Bethel", image: UIImage(named: "SFLogo")!)
        let song6 = Song.init(songID: "6", songTitle: "Oceans (shorter version)", songArtist: "Hillsong", songPath: "Oceans(long)-Hillsong")
        let song7 = Song.init(songID: "7", songTitle: "Unfailing Love", songArtist: "Chris Tomlin", songPath: "UnfailingLove-ChrisTomlin")
        let song8 = Song.init(songID: "8", songTitle: "What A Beautiful Name It Is", songArtist: "Hillsong", songPath: "WhatABeautifulNameItIs")
        let song9 = Song.init(songID: "9", songTitle: "Who You Say I Am", songArtist: "Hillsong", songPath: "WhoYouSayIAm")
        
        self.insertRowWithAnimation(row: 0, cell: song0) {
            self.insertRowWithAnimation(row: 1, cell: song1) {
                self.insertRowWithAnimation(row: 2, cell: song2) {
                    self.insertRowWithAnimation(row: 3, cell: song3) {
                        self.insertRowWithAnimation(row: 4, cell: song4) {
                            self.insertRowWithAnimation(row: 5, cell: song5) {
                                self.insertRowWithAnimation(row: 6, cell: song6) {
                                    self.insertRowWithAnimation(row: 7, cell: song7) {
                                        self.insertRowWithAnimation(row: 8, cell: song8) {
                                            self.insertRowWithAnimation(row: 9, cell: song9) {
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
        performSegue(withIdentifier: "toRequestIdentifier", sender: nil)
    }
    
//MARK: Helpers
    func insertRowWithAnimation(row: Int, cell: Song, completion: @escaping ()-> Void) { //cell animation
        let indexPath = IndexPath(row: row, section: 0)
        songs.append(cell)
        songsTableView.insertRows(at: [indexPath], with: .right) //insert rows from right side in 0.2 secs
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion()
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
                    vc.song = song
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
        performSegue(withIdentifier: "toRequestIdentifier", sender: song)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let song = songs[indexPath.row]
        performSegue(withIdentifier: "toSongInfoIdentifier", sender: song)
    }
}
