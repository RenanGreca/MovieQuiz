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
#import "MovieGrabber.h"

@interface ResultViewController() {
    Counter *counter;
}

@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UIImageView *imgPoster;
@property (weak, nonatomic) IBOutlet UILabel *lblCounter;
@property (weak, nonatomic) IBOutlet UILabel *lblMovie;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;

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
    _lblMovie.text = _movie.title;
    _lblCounter.text = [NSString stringWithFormat:@"%d", [counter counter]];

}

-(void)viewDidAppear:(BOOL)animated {
    NSURL *imgUrl = [NSURL URLWithString:_movie.img];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    _imgPoster.image = [UIImage imageWithData:imgData];
}

- (IBAction)buyOniTunes:(id)sender {
    NSString *iTunesURL = [MovieGrabber getiTunesURLWithTitle:_movie.title];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesURL]];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
