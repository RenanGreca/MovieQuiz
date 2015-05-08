//
//  OverController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/7/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit
import Social

class OverController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    var counter = Counter.Static.instance
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        lblCount.text = "\(counter.👍)"
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.popToRootViewControllerAnimated(true);
    }
    
    @IBAction func `return`(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true);
    }
    
    @IBAction func tweetBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetShare.setInitialText("I got \(counter.👍) out of 10 correct answers in #MovieQuiz! https://appstore.com/MovieQuiz")
            
            self.presentViewController(tweetShare, animated: true, completion: nil)
            
        } else {
            
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}