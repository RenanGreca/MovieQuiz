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
    var _seenMovies: Array<Movie> = []
    var index = 0
    
    struct Static {
        static let instance = MovieList()
    }
    
    func populate() -> Bool {
        _movies = fetchMovies(50)
        if _movies.count == 0 {
            return false
        }
        _movies.shuffle()
        fetch()
        return true
    }
    
    func reset() {
        _seenMovies = []
        _movies.shuffle()
        fetch()
        index = 0
    }
    
    func fetch() {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            getURLsAndImages(self._movies)
        }
    }
    
    func next() -> Movie {
        if index >= _movies.count {
            index = 0
        }
        return _movies[index++]
    }
    
    func getMovie(index: Int) -> Movie {
        return _movies[index]
    }
    
    func getRandomMovie() -> Movie {
        return _movies[0]
    }
    
    func getRandomMovies(count: Int, not:Movie) -> Array<Movie> {
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
                break
            }
            // Repeat while the random element is already in the random list
            do {
                random = true
                r = Int(arc4random_uniform(UInt32(_movies.count)))
                movie = _movies[r]
                
                let lMovies = movies.filter( { return $0._title == movie._title } )
                let sMovies = _seenMovies.filter( { return $0._title == movie._title } )
                
                if lMovies.count > 0 || sMovies.count > 0 || movie._title == not._title {
                    random = false
                }
            } while (!random)
            movies.append(movie)
            _seenMovies.append(movie)
        }
        
        return movies
    }
}
