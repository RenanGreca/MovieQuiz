//
//  MovieList.h
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Movie;

@interface MovieList : NSObject

@property NSMutableArray *movies;

+ (MovieList *) sharedInstance;

- (int)count;
- (Movie *)getMovie:(int)index;
- (Movie *)getRandomMovie;
- (Movie *)getRandomMovieThatIsNot:(Movie *)movie;

@end
