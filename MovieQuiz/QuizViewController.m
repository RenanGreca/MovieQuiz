//
//  QuizViewController.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "QuizViewController.h"
#import "ResultViewController.h"
#import "MovieList.h"
#import "Movie.h"

@interface QuizViewController () {
    MovieList *list;
    int ans;
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
    //Movie *movie = [list getRandomMovie];
    NSArray *movies = [list getRandomMovies:4];
    
    ans = arc4random_uniform((unsigned int) movies.count);

    _txtSynopsis.text = ((Movie *)movies[ans]).synopsis;
    
    _btn0.titleLabel.text = ((Movie *)movies[0]).title;
    _btn1.titleLabel.text = ((Movie *)movies[1]).title;
    _btn2.titleLabel.text = ((Movie *)movies[2]).title;
    _btn3.titleLabel.text = ((Movie *)movies[3]).title;
    
    //NSMutableArray *randomMovies = [list get:3 RandomMoviesThatAreNot:movie];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ResultViewController *result = [segue destinationViewController];
    BOOL correct = NO;
    
    if ([[segue identifier] isEqualToString:
                                [NSString stringWithFormat:@"sgMovie%d",ans]]){
        correct = YES;
    }
    result.correct = correct;
}


@end
