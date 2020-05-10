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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        print(self.lblRW.text)
        
        TimerManager.start(label: self.lblRW)

        movie = movieList.next
        movieList.prepareNext()
        movies = [movie]
        movies += movieList.getRandomMovies(count: 3, not:movie)
        movies.shuffle()
        
        for i in 0..<movies.count {
            if movies[i].title == movie.title {
                ans = i
                break
            }
        }
        
        //ans = Int(arc4random_uniform(UInt32(movies.count)))
        
        txtSynopsis.text = movie.synopsis
        
        btn0.setTitle(movies[0].title, for: .normal)
        btn1.setTitle(movies[1].title, for: .normal)
        btn2.setTitle(movies[2].title, for: .normal)
        btn3.setTitle(movies[3].title, for: .normal)
        
        loading = false
        
        /*let s: String
        if counter.👍==1 {
            s = ""
        } else {
            s = "s"
        }
        lblRW.text = "\(counter.👍) out of \(counter.total()) correct answer\(s)"*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getOMDbImg(movie: movie)
        getImageFromURL(movie: movie)
    }
    
    @IBAction func tappedAnswer(_ sender: UIButton) {
        if !loading {
            if sender == buttons[ans] {
                correct = true
                counter.right()
            } else {
                correct = false
                counter.wrong()
            }
            performSegue(withIdentifier: "sgAnswer", sender: self)
            loading = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sgAnswer") {
            let rC = segue.destination as! ResultController
            rC.movie = movies[ans]
            rC.correct = correct!
            TimerManager.pause()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
