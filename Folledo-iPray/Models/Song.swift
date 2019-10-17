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
    let songArtist: String?
    let songPath: String? //name of the song with extension
    let songImage: UIImage?
    var songURL: String = ""
    var songLength: Float = 0.0
    var songCategory1: String = ""
    var songLanguage: String = ""
    var songReligion: String = ""
    
    init(songID: String, songTitle: String, songArtist: String, songPath: String, image: UIImage = UIImage(named: "SFLogo")!) {
        self.songID = songID
        self.songTitle = songTitle
        self.songPath = songPath
        self.songImage = image
        self.songArtist = songArtist
    }
    
    init(dictionary: [String: Any]) {
        self.songID = dictionary[kSONGID] as? String
        self.songTitle = dictionary[kSONGTITLE] as? String
        self.songArtist = dictionary[kSONGARTIST] as? String
        self.songPath = dictionary[kSONGPATH] as? String
        
        self.songImage =  UIImage(data: dictionary[kSONGIMAGE] as! Data)
        
        self.songURL = dictionary[kSONGURL] as! String
        self.songLength = dictionary[kSONGLENGTH] as! Float
        self.songCategory1 = dictionary[kSONGCATEGORY1] as! String
        self.songLanguage = dictionary[kSONGLANGUAGE] as! String
        self.songReligion = dictionary[kSONGRELIGION] as! String
    }
    
    class func currentSong() -> Song? { //checks UserDefaults for current song, else return nil
        if let dictionary = UserDefaults.standard.object(forKey: kCURRENTSONG) {
            return Song.init(dictionary: dictionary as! [String : Any])
        }
        return nil
    }
}

func saveSongLocally(song: Song) { //persistently save song to UserDefaults
    UserDefaults.standard.set(songDictionaryFrom(song: song), forKey: kCURRENTSONG)
    UserDefaults.standard.synchronize()
    print("Finished saving song \(song.songTitle!) locally...")
}

func songDictionaryFrom(song: Song) -> NSDictionary { //take a song and return an NSDictionary
    return NSDictionary(
        objects: [song.songID!, song.songTitle!, song.songArtist!, song.songPath!, song.songImage!.jpegData(compressionQuality: 0.5)!, song.songURL, song.songLength, song.songCategory1, song.songLanguage, song.songReligion],
        forKeys: [kSONGID as NSCopying, kSONGTITLE as NSCopying, kSONGARTIST as NSCopying, kSONGPATH as NSCopying, kSONGIMAGE as NSCopying, kSONGURL as NSCopying, kSONGLENGTH as NSCopying, kSONGCATEGORY1 as NSCopying, kSONGLANGUAGE as NSCopying, kSONGRELIGION as NSCopying])
}


func updateCurrentSong(withValues: [String : Any], withBlock: @escaping(_ success: Bool) -> Void) { //withBlock makes it run in the background //method that saves our current songs values offline and online
    if UserDefaults.standard.object(forKey: kCURRENTSONG) != nil {
        guard let currentSong = Song.currentSong() else { return }
        let songObject = songDictionaryFrom(song: currentSong).mutableCopy() as! NSMutableDictionary //create a mutable dictionary from current song
        songObject.setValuesForKeys(withValues) //setValuesForKeys = Sets properties of the receiver with values from a given dictionary, using its keys to identify the properties.
        UserDefaults.standard.set(songObject, forKey: kCURRENTSONG)
        UserDefaults.standard.synchronize()
        withBlock(true)
    }
    withBlock(false)
}

