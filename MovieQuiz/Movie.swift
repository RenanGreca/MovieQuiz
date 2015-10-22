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
    let _title: String
    let _synopsis: String
    var _imgURL: String
    var _itunesURL: String = ""
    var _itimgURL: String = ""
    let _imdbID: String
    let _rating: String
    var _img: UIImage = UIImage(named: "MovieQuizLogo")!
    
    init(title: String, synopsis: String, imgURL: String, imdbID: String, rating: String) {
        _title = title
        _synopsis = synopsis
        _imgURL = imgURL
        _imdbID = "tt\(imdbID)"
        _rating = rating
    }
    
    func print() {
        println("\(_title)\n\(_synopsis)\n\(_imgURL)\n\(_itunesURL)")
    }
}