//
//  MovieList.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation

class MovieList {
    var movies: [Movie] = []
    var seenMovies: [Movie] = []
    var index = 0
    var next: Movie?
    
    struct Static {
        static let instance = MovieList()
    }
    
    /// Fills the `movies` array with data from an API.
    /// - Returns: `true` if the data retrieval was successful.
    func populate() -> Bool {
        movies = fetchMovies(limit: 50)
        if movies.count == 0 {
            return false
        }
        movies.shuffle()
        return true
    }
    
    
    /// Resets and reshuffles information for a new round of the game.
    func reset() {
        seenMovies = []
        if movies.count > 0 {
            movies.shuffle()
        }
        index = 0
    }
    
    /// Starts loarding information for the next movie that will be shown.
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
    
    /// Get `count` random movies from the list, while avoiding a specific movie.
    /// - Parameters:
    ///   - count: The number of movies we want.
    ///   - avoiding: The movie to avoid returning.
    /// - Returns: A `[Movie]` with `count` random movies.
    func getRandomMovies(count: Int, avoiding:Movie) -> [Movie] {
        return movies.getRandomElements(count: count, avoiding: avoiding)
    }
}
