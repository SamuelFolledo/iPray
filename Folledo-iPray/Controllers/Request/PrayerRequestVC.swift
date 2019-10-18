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
        continueButton.backgroundColor = kMAINCOLOR
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification object: nil)
        requestTextView.delegate = self
        if self.requestTextView.hasText {
            continueButton.setTitle("Done", for: .normal)
        } else {
            continueButton.setTitle("Skip", for: .normal)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
        self.view.addGestureRecognizer(tap)
//        requestTextView.text = "• " //• is option + 8 and ° is option + shift + 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil) //add observer for keyboard showing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        requestTextView.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    @objc func keyboardWillShow(notification: Notification) { //FB ep.13 5mins
            print("keyboard will show")
            
//            coverImageView_top.constant -= self.view.frame.width / 5.52 //FB ep.15 5mins //FB ep.19 7mins -= 75 is updated from constant to view's frame //if you divide the view's width by 75, we get 5.52, which will look the same proportions with this screen as well as other screen types
//            handsImageView_top.constant -= self.view.frame.width / 5.52 //FB ep.16 7mins //FB ep.19 7mins
//            whiteIconImageView_centerY.constant += self.view.frame.width / 8.28 //FB ep.16 4mins //FB ep.19 7mins += 50 updated to width / 8.28 which is 50
//
//            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { //FB ep.17 4mins will store info which is passed by the notification (there's a lot) but specifically only access the keyboard's frame when it just begins to show to the user. And unwrap it as  an NSValue which we can conver to a cgRectValue
//                registerButton_bottom.constant += keyboardSize.height //FB ep.17 6mins grab the keyboard's height
//            }
//
//            UIView.animate(withDuration: 0.5) { //FB ep.14 3mins
//                self.handsImageView.alpha = 0 //FB ep.14 5mins
//                self.view.layoutIfNeeded() //FB ep.15 5mins Lays out the subviews immediately, if layout updates are pending.
//            }
        }
        
    //will Hide keyboard
        @objc func keyboardWillHide(notification: Notification) { //FB ep.13 7mins
            print("keyboard will hide")
            
//            coverImageView_top.constant = coverImageView_topCache //FB ep.15 6mins //FB ep.19 12mins += 75 is updated to = coverImageView_topCache
//            handsImageView_top.constant = handsImageView_topCache //FB ep.16 7mins //FB ep.19 12mins
//            whiteIconImageView_centerY.constant = whiteIconImageView_centerYCache //FB ep.16 2mins //FB ep.19 12mins
//            
//            //if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { //FB ep.17 10mins
//            registerButton_bottom.constant = registerButton_bottomCache //FB ep.17 10mins
//            //}
//            
//            UIView.animate(withDuration: 0.5) { //FB ep.14 6mins
//                self.handsImageView.alpha = 1 //FB ep.14 6mins
//                self.view.layoutIfNeeded() //FB ep.15 7mins
//            }
            
        }
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
    
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) { //dismiss textView
        self.view.endEditing(false)
    }
}

extension PrayerRequestVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            UIView.animate(withDuration: 0.5) { //FB ep.14 6mins
                self.continueButton.setTitle("Skip", for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.5) { //FB ep.14 6mins
                self.continueButton.setTitle("Continue", for: .normal)
            }
        }
    }
}
