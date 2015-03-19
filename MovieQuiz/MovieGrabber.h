//
//  MovieGrabber.h
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieGrabber : NSObject

+ (void) put:(int)limit moviesInList:(NSMutableArray *)list;

@end
