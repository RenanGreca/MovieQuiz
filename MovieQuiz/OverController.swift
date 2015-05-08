//
//  OverController.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/7/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import UIKit

class OverController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    var counter = Counter.Static.instance
    
    override func viewDidLoad() {
        lblCount.text = "\(counter.👍)"
    }
}