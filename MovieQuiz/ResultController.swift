//
//  ResultController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var imgFresh: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var imgCheckX: UIImageView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var imgPoster: UIImageView!
    var timer = Timer.Static.instance
    var movie: Movie!
    var correct: Bool = false
    var counter = Counter.Static.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPoster.image = movie._img
        lblMovie.text = movie._title
        lblRating.text = movie._rating
        if movie._rating == "Rotten" {
            imgFresh.image = UIImage(named: "rotten")
        } else {
            imgFresh.image = UIImage(named: "fresh")
        }
        if correct {
            navItem.title = "Correct!"
            imgCheckX.image = UIImage(named: "icon-check")
        } else {
            navItem.title = "Wrong..."
            imgCheckX.image = UIImage(named: "icon-x")
            self.timer.add(30)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func next(sender: AnyObject) {
        if counter.👍 >= 10 {
            self.performSegueWithIdentifier("sgOver", sender: self);
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func iTunes(sender: AnyObject) {
        getStoreURL(movie)
        UIApplication.sharedApplication().openURL(NSURL(string: movie._itunesURL)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
