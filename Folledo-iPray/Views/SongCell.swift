//
//  SongCell.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/16/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    var song: Song!
    
//MARK: IBOutlets
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func populateCell() {
        self.songTitleLabel.text = song.songTitle!
        self.songImageView.image = song.songImage!
    }
}
