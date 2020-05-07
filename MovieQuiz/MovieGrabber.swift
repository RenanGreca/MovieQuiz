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
    let url = URL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=\(apikey)&page_limit=\(limit)")
    
    var returnMovies: Array<Movie> = []

    if let data = try? Data(contentsOf: url!) {
        var json = try? JSON(data:data)
        
        if let movies = json?["movies"].array {
            for movie in movies {
                let title = movie["title"].string!
                let synopsis = movie["synopsis"].string!
                let _ = movie["year"].int!
                let cleanSynopsis = synopsis.replaceAll(find: title, with: "_____")
                
                var rating = "unknown"
                if let ratings = movie["ratings"].dictionary {
                    rating = ratings["critics_rating"]!.string!
                }
                
                if let posters = movie["posters"].dictionary {
                    let imgURL = posters["original"]!.string!
                    if let ids = movie["alternate_ids"].dictionary {
                        let imdbID = ids["imdb"]!.string!
                        
                        let m = Movie(title: title, synopsis: cleanSynopsis, imgURL: imgURL, imdbID: imdbID, rating: rating)
                        returnMovies.append(m)
                    }
                }
            }
        }
    } else {
        print("Rotten Tomatoes 💩")
    }
    
    return returnMovies
}

func getURLsAndImages(movies: Array<Movie>) {
    for movie in movies {
        getStoreURL(movie: movie)
        getOMDbImg(movie: movie)
        getImageFromURL(movie: movie)
    }
}

func getStoreURL(movie: Movie) {
    if movie._itunesURL == "" {
        let cleanTitle = movie._title.replaceAll(find: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?entity=movie&term=\(cleanTitle)")
        let data = try? Data(contentsOf: url!)
        
        if data == nil {
            print("iTunes 💩")
            return;
        }
        
        let json = try? JSON(data: data!)
        
        movie._itunesURL = json!["results"][0]["trackViewUrl"].stringValue
        movie._itimgURL = json!["results"][0]["artworkUrl100"].stringValue
    }
}

func getOMDbImg(movie: Movie) {
    if (movie._img == UIImage(named: "MovieQuizLogo")) {
        let url = URL(string: "http://www.omdbapi.com/?i=\(movie._imdbID)&plot=short&r=json")
        let data = try? Data(contentsOf: url!)
        
        if data == nil {
            print("OMDb 💩")
            return
        }
        
        let json = try? JSON(data: data!)
        
        movie._imgURL = json!["Poster"].stringValue
        
        let imgdata = try? Data(contentsOf: URL(string: movie._imgURL)!)
        if let imgdata = imgdata {
            if let img = UIImage(data: imgdata) {
                movie._img = img
            }
        }
    }
}

func getImageFromURL(movie: Movie) {
    if (movie._img == UIImage(named: "MovieQuizLogo")) {
        let url = URL(string: movie._imgURL)
        let data = try? Data(contentsOf: url!)
        
        if data == nil {
            print("RT img 💩")
            return
        }
        
        if let img = UIImage(data: data!) {
            movie._img = img
        }
    }
}





