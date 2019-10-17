//
//  PrayerRequestVC.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/15/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class PrayerRequestVC: UIViewController {

//MARK: Properties
    var song: Song?
    var requests: [String]?
    
//MARK: IBOutlets
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var backButtonTapped: UIBarButtonItem!
    @IBOutlet weak var continueButton: UIButton!
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Prayer Requests"
        requestTextView.becomeFirstResponder()
        if self.requestTextView.hasText {
            continueButton.setTitle("Done", for: .normal)
        } else {
            continueButton.setTitle("Skip", for: .normal)
        }
//        requestTextView.text = "• " //• is option + 8 and ° is option + shift + 8
    }
    
    
//MARK: Private Methods
    
//MARK: IBActions
    @IBAction func doneButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toTimerIdentifier", sender: nil)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
//MARK: Helpers

}
