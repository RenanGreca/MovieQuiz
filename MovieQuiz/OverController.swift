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
    let timer = Timer.Static.instance
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.timer.updateTime()
        lblCount.text = "\(self.timer.label.text!)"
        
        reportScore()
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.popToRootViewControllerAnimated(true);
    }
    
    @IBAction func `return`(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true);
    }
    
    @IBAction func fbBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            fbShare.setInitialText("I got 10 correct answers in \(self.timer.label.text!) minutes in #MovieQuiz!")
            self.presentViewController(fbShare, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please log into a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBAction func tweetBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            tweetShare.setInitialText("I got 10 correct answers in \(self.timer.label.text!) minutes in #MovieQuiz!")
            self.presentViewController(tweetShare, animated: true, completion: nil)
            
        } else {
            
            var alert = UIAlertController(title: "Accounts", message: "Please log into a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func reportScore() {
        if GKLocalPlayer.localPlayer().authenticated {
            let gkScore = GKScore(leaderboardIdentifier: "besttimes")
            gkScore.value = Int64(self.timer.timeElapsed)
            GKScore.reportScores([gkScore], withCompletionHandler: { (error: NSError!) -> Void in
                if (error != nil) {
                    // handle error
                    println("Error: " + error.localizedDescription);
                } else {
                    println("Score reported: \(gkScore.value)")
                }
            })
        }
    }
}