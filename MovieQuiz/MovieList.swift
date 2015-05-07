//
//  MovieList.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation

class MovieList {
    var _movies: Array<Movie> = []
    
    struct Static {
        static let instance = MovieList()
    }
    
    func populate() -> Bool {
        _movies = fetchMovies(50)
        if _movies.count == 0 {
            return false
        }
        return true
    }
    
    func getMovie(index: Int) -> Movie {
        return _movies[index]
    }
    
    func getRandomMovie() -> Movie {
        return _movies[0]
    }
    
    func getRandomMovies(count: Int) -> Array<Movie> {
        if count > _movies.count {
            return _movies
        }
    
        var movies = Array<Movie>()
        var movie: Movie
        var random: Bool
        var r: Int
        
        for(var i=0; i<count; i++) {
            if (movies.count >= _movies.count) {
                // All elements were exausted, no more random choices available
                break;
            }
            // Repeat while the random element is already in the random list
            do {
                random = true;
                r = Int(arc4random_uniform(UInt32(_movies.count)))
                movie = _movies[r];
                for lMovie in movies {
                    if movie._title == lMovie._title {
                        random = false;
                        break;
                    }
                }
            } while (!random);
            movies.append(movie);
        }
        
        return movies
    }
}
