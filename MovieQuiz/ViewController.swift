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
//    let alert = UIAlertView(title: "Error", message: "Error aquiring movie list. Please check your Internet Connection.", delegate: nil, cancelButtonTitle: "OK")

    var gameCenterEnabled: Bool = false
    var leaderboardIdentifier:String = "besttimes"
    let localPlayer = GKLocalPlayer.local
    
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.titleView = UIImageView(image: UIImage(named:"MovieQuizLogoHS"))
        
        if !movieList.populate() {
            print("Error aquiring movie list.")
//            let alert = UIAlertView(title: "Error", message: "Error aquiring movie list. Please check your Internet Connection.", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
        }
        movieList.prepareNext()
        
        authenticateLocalPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        counter.reset()
        TimerManager.reset()
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
                self.present(viewController!, animated: true, completion:nil)
            } else {
                if (self.localPlayer.isAuthenticated) {
                    self.gameCenterEnabled = true
                    self.localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { leaderboardIdentifier, error in
                        if error != nil {
                            print(error!.localizedDescription)
                        } else {
                            self.leaderboardIdentifier = leaderboardIdentifier!
                        }
                    })
                } else {
                    self.gameCenterEnabled = false
                }
            }
        }
        print(self.localPlayer)
        print(leaderboardIdentifier)
    }
    
    func showLeaderboard() {
        // only show the leaderboard if game center is enabled
        if self.gameCenterEnabled {
            let gameCenterViewController = GKGameCenterViewController()
            gameCenterViewController.gameCenterDelegate = self
            
            gameCenterViewController.viewState = GKGameCenterViewControllerState.leaderboards
            gameCenterViewController.leaderboardIdentifier = self.leaderboardIdentifier
            
            self.present(gameCenterViewController, animated: true, completion: nil)
        } else {
            // Tell the user something useful about the fact that game center isn't enabled on their device
        }
        
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

    @IBAction func start(_ sender: UIButton) {
        if movieList.movies.count == 0 {
            if !movieList.populate() {
                print("Error aquiring movie list.")
//                let alert = UIAlertView(title: "Error", message: "Error aquiring movie list. Please check your Internet Connection.", delegate: nil, cancelButtonTitle: "OK")
//                alert.show()
                return
            }
        }
        if let _ = movieList.next {
            performSegue(withIdentifier: "sgQuiz", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

