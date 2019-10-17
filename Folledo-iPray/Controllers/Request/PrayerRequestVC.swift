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
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification object: nil)
        
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
//    @objc func adjustForKeyboard(notification: Notification) {
//        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//
//        let keyboardScreenEndFrame = keyboardValue.cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
//
//        if notification.name == UIResponder.keyboardWillHideNotification {
//            script.contentInset = .zero
//        } else {
//            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
//        }
//
//        script.scrollIndicatorInsets = script.contentInset
//
//        let selectedRange = script.selectedRange
//        script.scrollRangeToVisible(selectedRange)
//    }
}
