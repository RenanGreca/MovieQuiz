//
//  MovieGrabber.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import SwiftyJSON

func fetchMovies(limit: Int) -> Array<Movie> {
    let apikey = "asprbevazhnusm6fjwqnk24d"
    
    // create the request
    let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=\(apikey)&page_limit=\(limit)")
    let data = NSData(contentsOfURL: url!)
    
    if data == nil {
        println("Rotten Tomatoes 💩")
        return []
    }
    
    var error: NSErrorPointer
    let json = NSJSONSerialization.JSONObjectWithData(data!,
      options: NSJSONReadingOptions.MutableContainers, error: nil) as! [String:AnyObject]
    
    var returnMovies: Array<Movie> = []
    
    if let movies = json["movies"] as? NSArray {
        for movie in movies {
            let title = movie["title"] as! String
            let synopsis = movie["synopsis"] as! String
            let cleanSynopsis = synopsis.replaceAll(title, with: "_____")
            if let posters = movie["posters"] as? NSDictionary {
                let imgURL = posters["original"] as! String
                
                var m = Movie(title: title, synopsis: cleanSynopsis, imgURL: imgURL)
                returnMovies.append(m)
            }
        }
    }
    
    return returnMovies
}

func getURLsAndImages(movies: Array<Movie>) {
    for (var i=0; i<10; ++i) {
        let movie = movies[i]
        getStoreURL(movie)
        getImageFromURL(movie)
    }
}

func getStoreURL(movie: Movie) {
    if movie._itunesURL == "" {
        let cleanTitle = movie._title.replaceAll(" ", with: "+")
        let url = NSURL(string: "https://itunes.apple.com/search?entity=movie&term=\(cleanTitle)")
        let data = NSData(contentsOfURL: url!)
        
        if data == nil {
            println("iTunes 💩")
        }
        
        var error: NSErrorPointer
        let json = JSON(data: data!)
        
        if let trackUrl = json["results"][0]["trackViewUrl"].stringValue as? String {
            movie._itunesURL = trackUrl
        }
        if let imgUrl = json["results"][0]["artworkUrl100"].stringValue as? String {
            movie._itimgURL = imgUrl
        }
    }
}

func getImageFromURL(movie: Movie) {
    if (movie._img == UIImage(named: "MovieQuizLogo")) {
        let url = NSURL(string: movie._itimgURL)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
            if let img = UIImage(data: data!) {
                movie._img = img
            }
        } else {
            let url = NSURL(string: movie._imgURL)
            let data = NSData(contentsOfURL: url!)
            if data != nil {
                if let img = UIImage(data: data!) {
                    movie._img = img
                }
            }
        }
    }
}





