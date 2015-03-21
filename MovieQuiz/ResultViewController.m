//
//  ResultViewController.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/20/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "ResultViewController.h"
#import "Movie.h"
#import "Counter.h"

@interface ResultViewController() {
    Counter *counter;
}

@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UIImageView *imgPoster;
@property (weak, nonatomic) IBOutlet UILabel *lblCounter;

@end


@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    counter = [Counter sharedInstance];
}

-(void)viewWillAppear:(BOOL)animated {
    if (_correct) {
        _lblResult.text = @"Correct!";
        [counter add];
    } else {
        _lblResult.text = @"Wrong!";
    }

    [counter save];
    
    //NSLog(@"%@", _movie.img);
    NSURL *imgUrl = [NSURL URLWithString:_movie.img];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    _imgPoster.image = [UIImage imageWithData:imgData];
    
    _lblCounter.text = [NSString stringWithFormat:@"%d", [counter counter]];

}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
