//
//  ResultViewController.h
//  MovieQuiz
//
//  Created by Renan Greca on 3/20/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface ResultViewController : UIViewController

@property BOOL correct;
@property Movie *movie;

@end
