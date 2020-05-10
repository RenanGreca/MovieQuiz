//
//  MovieList.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation

class MovieList {
    var movies: Array<Movie> = []
    var seenMovies: Array<Movie> = []
    var index = 0
    var next:Movie?
    
    struct Static {
        static let instance = MovieList()
    }
    
    func populate() -> Bool {
        movies = fetchMovies(limit: 50)
        if movies.count == 0 {
            return false
        }
        movies.shuffle()
//        fetch()
        return true
    }
    
    func reset() {
        seenMovies = []
        if movies.count > 0 {
            movies.shuffle()
//            fetch()
        }
        index = 0
    }
    
    func fetch() {
//        DispatchQueue.global().async {
////        DispatchQueue.main.async {
//            getURLsAndImages(movies: self.movies)
//        }
    }
    
    func prepareNext() {
        if index >= movies.count {
            index = 0
        }
        index += 1
        let nextMovie = movies[index]
        DispatchQueue.global().async {
            getURLsAndImages(movie: nextMovie)
            self.next = nextMovie
        }
    }
    
    func getMovie(index: Int) -> Movie {
        return movies[index]
    }
    
    func getRandomMovie() -> Movie {
        return movies[0]
    }
    
    func getRandomMovies(count: Int, not:Movie) -> Array<Movie> {
        if count > movies.count {
            return movies
        }
    
        var movies = Array<Movie>()
        var movie: Movie
        var random: Bool
        var r: Int
        
        for _ in 0..<count {
            if (movies.count >= self.movies.count) {
                // All elements were exausted, no more random choices available
                break
            }
            // Repeat while the random element is already in the random list
            repeat {
                random = true
                r = Int(arc4random_uniform(UInt32(self.movies.count)))
                movie = self.movies[r]
                
                let lMovies = movies.filter( { return $0.title == movie.title } )
                
                /*print(_seenMovies.count)
                let sMovies = seenMovies.filter( { return $0._title == movie._title } )
                print(sMovies.count)*/
                
                if lMovies.count > 0 || /*sMovies.count > 0 ||*/ movie.title == not.title {
                    random = false
                }
            } while (!random)
            movies.append(movie)
        }
        
        //seenMovies.append(not)
        return movies
    }
}
