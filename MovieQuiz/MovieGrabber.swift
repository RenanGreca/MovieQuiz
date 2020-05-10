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
//    let apikey = "asprbevazhnusm6fjwqnk24d"
    let apikey = "k_x7Ahx727"
    
    // create the request
//    let url = URL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=\(apikey)&page_limit=\(limit)")
    let url = URL(string: "https://imdb-api.com/en/API/MostPopularMovies/\(apikey)")
    
    var returnMovies: Array<Movie> = []

    if let data = try? Data(contentsOf: url!) {
        var json = try? JSON(data:data)
        
        if let movies = json?["items"].array {
            for i in 0..<limit {
                let movie = movies[i]
                let imdbID = movie["id"].string!
                let title = movie["title"].string!
//                let synopsis = movie["synopsis"].string!
//                let _ = movie["year"].string!
//                let cleanSynopsis = synopsis.replaceAll(find: title, with: "_____")
                
                var rating = movie["imDbRating"].string!
//                if let ratings = movie["ratings"].dictionary {
//                    rating = ratings["critics_rating"]!.string!
//                }
                let imgURL = ""// movie["image"].string!
                
                let m = Movie(title: title, synopsis: "", imgURL: imgURL, imdbID: imdbID, rating: rating)
                returnMovies.append(m)
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

func getURLsAndImages(movie: Movie) {
    getStoreURL(movie: movie)
    getOMDbImg(movie: movie)
    getImageFromURL(movie: movie)
}

func getStoreURL(movie: Movie) {
    if movie.itunesURL == "" {
        let cleanTitle = movie.title.replaceAll(find: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?entity=movie&term=\(cleanTitle)")
        let data = try? Data(contentsOf: url!)
        
        if data == nil {
            print("iTunes 💩")
            return;
        }
        
        let json = try? JSON(data: data!)
        
        movie.itunesURL = json!["results"][0]["trackViewUrl"].stringValue
        movie.itimgURL = json!["results"][0]["artworkUrl100"].stringValue
    }
}

func getOMDbImg(movie: Movie) {
    if (movie.img == UIImage(named: "MovieQuizLogo")) {
        let url = URL(string: "http://www.omdbapi.com/?i=\(movie.imdbID)&plot=short&r=json&apikey=a30d2863")
        let data = try? Data(contentsOf: url!)
        
        if data == nil {
            print("OMDb 💩")
            return
        }
        
        let json = try? JSON(data: data!)
        
        movie.imgURL = json!["Poster"].stringValue
        
        let imgdata = try? Data(contentsOf: URL(string: movie.imgURL)!)
        if let imgdata = imgdata {
            if let img = UIImage(data: imgdata) {
                movie.img = img
            }
        }
        
        movie.synopsis = json!["Plot"].stringValue
    }
}

func getImageFromURL(movie: Movie) {
    if (movie.img == UIImage(named: "MovieQuizLogo")) {
        let url = URL(string: movie.imgURL)
        let data = try? Data(contentsOf: url!)
        
        if data == nil {
            print("RT img 💩")
            return
        }
        
        if let img = UIImage(data: data!) {
            movie.img = img
        }
    }
}





