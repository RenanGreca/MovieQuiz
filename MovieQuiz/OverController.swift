//
//  OverController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/7/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit
import Social
import GameKit

class OverController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    var counter = Counter.Static.instance
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        TimerManager.updateTime()
        lblCount.text = "\(TimerManager.label.text!)"
        
        reportScore()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popToRootViewController(animated: true);
    }
    
    @IBAction func `return`(sender: AnyObject) {
        navigationController?.popToRootViewController(animated: true);
    }
    
    @IBAction func fbBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            fbShare.setInitialText("I got 10 correct answers in \(TimerManager.label.text!) minutes in #MovieQuiz!")
            self.present(fbShare, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please log into a Facebook account to share.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func tweetBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            tweetShare.setInitialText("I got 10 correct answers in \(TimerManager.label.text!) minutes in #MovieQuiz!")
            self.present(tweetShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please log into a Twitter account to tweet.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reportScore() {
        if GKLocalPlayer.local.isAuthenticated {
            let gkScore = GKScore(leaderboardIdentifier: "besttimes")
            gkScore.value = Int64(TimerManager.timeElapsed)
            GKScore.report([gkScore], withCompletionHandler: {error in
                if (error != nil) {
                    // handle error
                    print("Error: " + error!.localizedDescription);
                } else {
                    print("Score reported: \(gkScore.value)")
                }
            })
        }
    }
}
