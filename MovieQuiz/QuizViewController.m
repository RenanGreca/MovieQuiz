//
//  QuizViewController.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "QuizViewController.h"
#import "MovieList.h"
#import "Movie.h"

@interface QuizViewController () {
    MovieList *list;
}

@property (weak, nonatomic) IBOutlet UITextView *txtSynopsis;

@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *lblCount;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    list = [MovieList sharedInstance];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog (@"1");
    if (list.movies.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error aquiring movie list. Check your Internet connection."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    Movie *movie = [list getRandomMovie];
    _txtSynopsis.text = movie.synopsis;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
