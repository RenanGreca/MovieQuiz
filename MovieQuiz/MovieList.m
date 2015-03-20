//
//  MovieList.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "MovieList.h"
#import "Movie.h"
#import "MovieGrabber.h"

@implementation MovieList

+ (MovieList *) sharedInstance {
    static MovieList *_sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        _sharedInstance = [[super alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _movies = [[NSMutableArray alloc] init];
        [self populate];
    }
    return self;
}

- (void) populate {
    if (![MovieGrabber put:20 moviesInList:_movies]) {
        NSLog(@"Error grabbing movies");
    }
}

- (int) count {
    return (int) _movies.count;
}

- (Movie *)getMovie:(int)index {
    return [_movies objectAtIndex:index];
}

- (Movie *)getRandomMovie {
    return [_movies objectAtIndex: arc4random_uniform((unsigned int) [self count])];
}

- (NSArray *)get:(int)count RandomMoviesThatAreNot:(Movie *)movie {
    NSMutableArray *randomMovies = [[NSMutableArray alloc] init];
    Movie *rMovie;
    int r;
    BOOL random;
    if (count >= [self count]) {
        return nil;
    }

    for (int i=0; i<count; i++) {
        if (randomMovies.count >= [self count]) {
            // All elements were exausted, no more random choices available
            break;
        }
        // Repeat while the random element is already in the random list
        do {
            random = YES;
            r = arc4random_uniform((unsigned int) [self count]);
            rMovie = [_movies objectAtIndex:r];
            for (Movie *lMovie in randomMovies) {
                if ([rMovie.title isEqualToString:lMovie.title]) {
                    random = NO;
                    break;
                }
            }
        } while (!random);
        [randomMovies addObject:rMovie];
    }
    return randomMovies;
}

- (NSArray *)getRandomMovies:(int)count {
    NSMutableArray *randomMovies = [[NSMutableArray alloc] init];
    Movie *rMovie;
    int r;
    BOOL random;
    if (count >= [self count]) {
        return nil;
    }
    
    for (int i=0; i<count; i++) {
        if (randomMovies.count >= [self count]) {
            // All elements were exausted, no more random choices available
            break;
        }
        // Repeat while the random element is already in the random list
        do {
            random = YES;
            r = arc4random_uniform((unsigned int) [self count]);
            rMovie = [_movies objectAtIndex:r];
            for (Movie *lMovie in randomMovies) {
                if ([rMovie.title isEqualToString:lMovie.title]) {
                    random = NO;
                    break;
                }
            }
        } while (!random);
        [randomMovies addObject:rMovie];
    }
    return randomMovies;
}



@end
