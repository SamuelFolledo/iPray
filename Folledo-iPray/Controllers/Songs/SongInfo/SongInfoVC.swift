//
//  SongInfoVC.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/16/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class SongInfoVC: UIViewController {

//MARK: Properties
    var song: Song?
    
//MARK: IBOutlets
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = song!.songTitle
        songImageView.image = song?.songImage
    }
    
    
//MARK: Private Methods
    
//MARK: IBActions
    
//MARK: Helpers

}
