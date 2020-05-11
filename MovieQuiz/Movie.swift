//
//  Movie.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.imdbID == rhs.imdbID
    }
    
    let title: String
    var synopsis: String = ""
    var imgURL: String = ""
    var itunesURL: String = ""
    var itimgURL: String = ""
    let imdbID: String
    let rating: String
    var img: UIImage = UIImage(named: "MovieQuizLogo")!
    
//    init(title: String, synopsis: String, imgURL: String, imdbID: String, rating: String) {
//        self.title = title
//        self.synopsis = synopsis
//        self.imgURL = imgURL
//        self.imdbID = "\(imdbID)"
//        self.rating = rating
//    }
    
    init?(json: JSON)  {
        guard let title = json["title"].string,
              let imdbID = json["id"].string,
              let rating = json["imDbRating"].string else {
                return nil
        }
        
        self.title = title
        self.imdbID = imdbID
        self.rating = rating
    }
    
}
