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
       let movies = try? JSON(data: data)["items"].array {
        var i = 0
        while i < limit {
            if let movie = Movie(json: movies[i]) {
                returnMovies.append(movie)
                i += 1
            }
        }
    } else {
        print("Error fetching IMDb API data.")
    }
    
    return returnMovies
}

func getURLsAndImages(movies: [Movie]) {
    for movie in movies {
        getStoreURL(movie: movie)
        getOMDbImg(movie: movie)
//        getImageFromURL(movie: movie)
    }
}

func getURLsAndImages(movie: Movie) {
    getStoreURL(movie: movie)
    getOMDbImg(movie: movie)
//    getImageFromURL(movie: movie)
}

func getStoreURL(movie: Movie) {
    if movie.iTunesURL == nil {
        let cleanTitle = movie.title.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?entity=movie&term=\(cleanTitle)")
        
        guard let data = try? Data(contentsOf: url!) else {
            print("iTunes 💩")
            return
        }
        
        movie.iTunesURL = try? JSON(data: data)["results"][0]["trackViewUrl"].string
    }
}

func getOMDbImg(movie: Movie) {
    if (movie.img == UIImage(named: "MovieQuizLogo")) {
        let url = URL(string: "http://www.omdbapi.com/?i=\(movie.imdbID)&plot=short&r=json&apikey=\(APIKeys.OMDb)")
        guard let data = try? Data(contentsOf: url!) else {
            print("OMDb 💩")
            return
        }
        
        if let json = try? JSON(data: data) {
            movie.imgURL = json["Poster"].string ?? ""
            
            if let imgdata = try? Data(contentsOf: URL(string: movie.imgURL)!) {
                if let img = UIImage(data: imgdata) {
                    movie.img = img
                }
            }
            
            movie.synopsis = json["Plot"].string ?? ""
        }
        
    }
}

func getImageFromURL(movie: Movie) {
    if (movie.img == UIImage(named: "MovieQuizLogo")) {
        let url = URL(string: movie.imgURL)
        guard let data = try? Data(contentsOf: url!) else {
            print("RT img 💩")
            return
        }
        
        if let img = UIImage(data: data) {
            movie.img = img
        }
    }
}





