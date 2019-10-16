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
    var songs: [Song] = []
//MARK: IBOutlets
    @IBOutlet weak var songsTableView: UITableView!
    
    @IBOutlet weak var doneButton: UIButton!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
//MARK: Private Methods
    
    
    
//MARK: IBActions
    @IBAction func doneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toRequestIdentifier", sender: nil)
    }
    
//MARK: Helpers

}

extension SongsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
