//
//  QuizController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class QuizController: UIViewController {
    
    let movieList = MovieList.Static.instance
    let counter = Counter.Static.instance
    var movies = Array<Movie>()
    var ans = 0

    @IBOutlet weak var txtSynopsis: UITextView!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.titleView = UIImageView(image: UIImage(named:"MovieQuizLogoHS"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        movies = movieList.getRandomMovies(4)
        ans = Int(arc4random_uniform(UInt32(movies.count)))
        
        txtSynopsis.text = movies[ans]._synopsis
        
        btn0.setTitle(movies[0]._title, forState: UIControlState.Normal)
        btn1.setTitle(movies[1]._title, forState: UIControlState.Normal)
        btn2.setTitle(movies[2]._title, forState: UIControlState.Normal)
        btn3.setTitle(movies[3]._title, forState: UIControlState.Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        let url = NSURL(string: movies[ans]._imgURL)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imageURL.image = UIImage(data: data!)
    }
    
    @IBAction func tappedAnswer(sender: UIButton) {
        performSegueWithIdentifier("sgAnswer", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}