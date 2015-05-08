//
//  ViewController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/5/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let movieList = MovieList.Static.instance
    let counter = Counter.Static.instance
    let alert = UIAlertView(title: "Error", message: "Error aquiring movie list. Please check your Internet Connection.", delegate: nil, cancelButtonTitle: "OK")

    
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.titleView = UIImageView(image: UIImage(named:"MovieQuizLogoHS"))
        
        if !movieList.populate() {
            alert.show()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        counter.reset()
        movieList.reset()
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

