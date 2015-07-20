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
    var timer = Timer.Static.instance
    var movies = Array<Movie>()
    var movie: Movie!
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
        self.timer.start(self.lblRW)

        movie = movieList.next()
        movies = [movie]
        movies += movieList.getRandomMovies(3, not:movie)
        movies.shuffle()
        
        for (var i=0; i<movies.count; ++i) {
            if movies[i]._title == movie._title {
                ans = i
                break
            }
        }
        
        //ans = Int(arc4random_uniform(UInt32(movies.count)))
        
        txtSynopsis.text = movie._synopsis
        
        btn0.setTitle(movies[0]._title, forState: UIControlState.Normal)
        btn1.setTitle(movies[1]._title, forState: UIControlState.Normal)
        btn2.setTitle(movies[2]._title, forState: UIControlState.Normal)
        btn3.setTitle(movies[3]._title, forState: UIControlState.Normal)
        
        loading = false
        
        /*let s: String
        if counter.👍==1 {
            s = ""
        } else {
            s = "s"
        }
        lblRW.text = "\(counter.👍) out of \(counter.total()) correct answer\(s)"*/
    }
    
    override func viewDidAppear(animated: Bool) {
        getOMDbImg(movie)
        getImageFromURL(movie)
    }
    
    @IBAction func tappedAnswer(sender: UIButton) {
        if !loading {
            if sender == buttons[ans] {
                correct = true
                counter.right()
            } else {
                correct = false
                counter.wrong()
            }
            performSegueWithIdentifier("sgAnswer", sender: self)
            loading = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sgAnswer") {
            var rC = segue.destinationViewController as! ResultController
            rC.movie = movies[ans]
            rC.correct = correct!
            self.timer.pause()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}