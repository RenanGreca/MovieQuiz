//
//  Movie.h
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString *title;
@property NSString *synopsis;
@property NSString *img;
@property NSString *iTunesURL;

+ (id) MovieWithTitle:(NSString *)title andSynopsis:(NSString *)synopsis andImg:(NSString *)img;
- (id) initWithTitle:(NSString *)title andSynopsis:(NSString *)synopsis andImg:(NSString *)img;

@end
