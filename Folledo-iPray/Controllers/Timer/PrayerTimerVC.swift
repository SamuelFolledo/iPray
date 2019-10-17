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
    
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
//MARK: Private Methods
    
//MARK: IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
//MARK: Helpers

}
