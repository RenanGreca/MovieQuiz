//
//  ViewController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/5/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate {
    
    let movieList = MovieList.Static.instance
    let counter = Counter.Static.instance
    let timer = Timer.Static.instance
    let alert = UIAlertView(title: "Error", message: "Error aquiring movie list. Please check your Internet Connection.", delegate: nil, cancelButtonTitle: "OK")

    var gameCenterEnabled: Bool = false
    var leaderboardIdentifier:String = "besttimes"
    let localPlayer = GKLocalPlayer.localPlayer()
    
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.titleView = UIImageView(image: UIImage(named:"MovieQuizLogoHS"))
        
        if !movieList.populate() {
            alert.show()
        }
        
        authenticateLocalPlayer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        counter.reset()
        timer.reset()
        movieList.reset()
    }
    
    // MARK GameCenter integration
    
    @IBAction func leaderboardTouched(sender: AnyObject) {
        authenticateLocalPlayer()
        showLeaderboard()
    }
    
    func authenticateLocalPlayer() {
        self.localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) {
                self.presentViewController(viewController, animated: true, completion:nil)
            } else {
                if (self.localPlayer.authenticated) {
                    self.gameCenterEnabled = true
                    self.localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifier : String!, error : NSError!) -> Void in
                        if error != nil {
                            println(error.localizedDescription)
                        } else {
                            self.leaderboardIdentifier = leaderboardIdentifier
                        }
                    })
                } else {
                    self.gameCenterEnabled = false
                }
            }
        }
        println(self.localPlayer)
        println(leaderboardIdentifier)
    }
    
    func showLeaderboard() {
        // only show the leaderboard if game center is enabled
        if self.gameCenterEnabled {
            let gameCenterViewController = GKGameCenterViewController()
            gameCenterViewController.gameCenterDelegate = self
            
            gameCenterViewController.viewState = GKGameCenterViewControllerState.Leaderboards
            gameCenterViewController.leaderboardIdentifier = self.leaderboardIdentifier
            
            self.presentViewController(gameCenterViewController, animated: true, completion: nil)
        } else {
            // Tell the user something useful about the fact that game center isn't enabled on their device
        }
        
    }

    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func start(sender: AnyObject) {
        if movieList._movies.count == 0 {
            if !movieList.populate() {
                alert.show()
                return
            }
        }
        performSegueWithIdentifier("sgQuiz", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

