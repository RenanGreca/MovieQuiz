//
//  ResultController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var imgCheckX: UIImageView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var imgPoster: UIImageView!
    
    @IBOutlet weak var iTunesImage: UIImageView!
    @IBOutlet weak var iTunesButton: UIButton!
    
    var movie: Movie!
    var correct: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPoster.image = movie.img
        lblMovie.text = movie.title
        lblRating.text = movie.rating
        
        if (movie.iTunesURL != "") {
            self.iTunesImage.isHidden = false
            self.iTunesButton.isHidden = false
        }
        
        if correct {
            navItem.title = "Correct!"
            imgCheckX.image = UIImage(named: "icon-check")
        } else {
            navItem.title = "Wrong..."
            imgCheckX.image = UIImage(named: "icon-x")
            TimerManager.add(seconds: 30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func next(_ sender: AnyObject) {
        if Counter.rightAnswers >= 10 {
            self.performSegue(withIdentifier: "sgOver", sender: self);
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func iTunes(_ sender: AnyObject) {
        if let url = movie.iTunesURL {
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
