//
//  LoadViewController.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/20/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "LoadViewController.h"
#import "MovieList.h"

@interface LoadViewController () {
    MovieList *list;
}
@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    list = [MovieList sharedInstance];
    if (list.movies.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error aquiring movie list. Check your Internet connection."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        //SEL dismiss = @selector(dismissViewControllerAnimated:completion:);
        

        //[alert canPerformAction:dismiss withSender:self];
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
}

/*- (SEL) dismiss:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}*/

@end
