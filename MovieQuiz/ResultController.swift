//
//  ResultController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var lblCorrect: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var imgPoster: UIImageView!
    var movie: Movie!
    var correct: Bool = false
    var counter = Counter.Static.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        imgPoster.image = movie._img
        lblMovie.text = movie._title
        if correct {
            lblCorrect.text = ""
            navItem.title = "Correct!"
        } else {
            lblCorrect.text = ""
            navItem.title = "Wrong..."
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func next(sender: AnyObject) {
        if counter.total() >= 10 {
            self.performSegueWithIdentifier("sgOver", sender: self);
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func iTunes(sender: AnyObject) {
        if movie._itunesURL == "" {
            movie._itunesURL = getStoreURL(movie._title)
        }
        UIApplication.sharedApplication().openURL(NSURL(string: movie._itunesURL)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
