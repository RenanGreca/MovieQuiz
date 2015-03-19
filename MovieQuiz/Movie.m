//
//  Movie.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (id)MovieWithTitle:(NSString *)title andSynopsis:(NSString *)synopsis andImg:(NSString *)img {
    Movie *movie = [[Movie alloc] initWithTitle:title andSynopsis:synopsis andImg:img];
    return movie;
}

- (id)initWithTitle:(NSString *)title andSynopsis:(NSString *)synopsis andImg:(NSString *)img {
    self = [super init];
    if (self) {
        _title = title;
        _synopsis = synopsis;
        _img = img;
    }
    return self;
}

- (id)initFromDictionary:(NSDictionary *)dict {
    return self;
}

@end
