//
//  QuizController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class QuizController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    let movieList = MovieList.Static.instance
    let counter = Counter.Static.instance
    var movies = Array<Movie>()
    var buttons = Array<UIButton>()
    var ans = 0
    var correct: Bool?
    var loading: Bool!

    @IBOutlet weak var txtSynopsis: UITextView!
    @IBOutlet weak var lblRW: UILabel!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.titleView = UIImageView(image: UIImage(named:"MovieQuizLogoHS"))

        buttons.append(btn0)
        buttons.append(btn1)
        buttons.append(btn2)
        buttons.append(btn3)
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
        
        loading = false
        
        var s: String
        if counter.👍==1 {
            s = ""
        } else {
            s = "s"
        }
        lblRW.text = "\(counter.👍) out of \(counter.total()) correct answer\(s)"
    }
    
    override func viewDidAppear(animated: Bool) {
        let url = NSURL(string: movies[ans]._imgURL)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        if let img = UIImage(data: data!) {
            movies[ans]._img = img
        }
    }
    
    @IBAction func tappedAnswer(sender: UIButton) {
        if sender == buttons[ans] {
            correct = true
            counter.right()
        } else {
            correct = false
            counter.wrong()
        }
        if !loading {
            performSegueWithIdentifier("sgAnswer", sender: self)
            loading = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sgAnswer") {
            var rC = segue.destinationViewController as! ResultController
            rC.movie = movies[ans]
            rC.correct = correct!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}