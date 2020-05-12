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
    // create the request
    let url = URL(string: "https://imdb-api.com/en/API/MostPopularMovies/\(APIKeys.IMDb)")
    
    var returnMovies: Array<Movie> = []

    if let data = try? Data(contentsOf: url!),
       let json = try? JSON(data: data),
       let movies = json["items"].array {
        var i = 0
        while i < limit {
            if let movie = Movie(json: movies[i]) {
                returnMovies.append(movie)
                i += 1
            }
        }
    } else {
        print("Error fetching API data.")
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
        let url = URL(string: "http://www.omdbapi.com/?i=\(movie.imdbID)&plot=short&r=json&apikey=\(APIKeys.OMDb)")
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





