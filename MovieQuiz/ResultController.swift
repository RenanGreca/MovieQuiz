//
//  ResultController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController!.navigationBar.topItem!.titleView = UIImageView(image: UIImage(named:"MovieQuizLogoHS"))
        
        imgPoster.image = UIImage()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func next(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func iTunes(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
