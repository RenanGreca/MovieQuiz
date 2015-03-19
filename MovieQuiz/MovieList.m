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
        NSLog(@"Error");
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

- (Movie *)getRandomMovieThatIsNot:(Movie *)movie {
    Movie *rMovie;
    do {
        rMovie = [_movies objectAtIndex: arc4random_uniform((unsigned int) [self count])];
    } while ([rMovie.title isEqualToString:movie.title]);
    return rMovie;
}


@end
