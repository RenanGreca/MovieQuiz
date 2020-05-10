//
//  Movie.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    let title: String
    var synopsis: String = ""
    var imgURL: String
    var itunesURL: String = ""
    var itimgURL: String = ""
    let imdbID: String
    let rating: String
    var img: UIImage = UIImage(named: "MovieQuizLogo")!
    
    init(title: String, synopsis: String, imgURL: String, imdbID: String, rating: String) {
        self.title = title
        self.synopsis = synopsis
        self.imgURL = imgURL
        self.imdbID = "\(imdbID)"
        self.rating = rating
    }
    
    func print() {
        Swift.print("\(title)\n\(synopsis)\n\(imgURL)\n\(itunesURL)")
    }
}
