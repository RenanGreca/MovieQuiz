//
//  ViewController.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "ViewController.h"
#import "MovieGrabber.h"
#import "Counter.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblCounter;

@end

@implementation ViewController {
    Counter *counter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    counter = [Counter sharedInstance];
    _lblCounter.text = [NSString stringWithFormat:@"%d", [counter counter]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
