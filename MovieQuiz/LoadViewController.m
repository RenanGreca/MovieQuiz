
//
//  LoadViewController.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/20/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "LoadViewController.h"
#import "QuizViewController.h"
#import "MovieList.h"
#import "Counter.h"

@interface LoadViewController () {
    MovieList *list;
    int number;
    
    NSString *name;
    int age;
    
    Counter *counter;
}
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIView *viewBlock;
@property (weak, nonatomic) IBOutlet UIView *pkrAge;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;

@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    number = 99;
}

- (void)viewWillAppear:(BOOL)animated {
    /*if (!self.isMovingToParentViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
        // we're already on the navigation stack
        // another controller must have been popped off
    }*/

    
    //_viewBlock.hidden = NO;
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
    
    counter = [Counter sharedInstance];
    if (counter.counter != 0) {
        [self performSegueWithIdentifier:@"sgQuiz" sender:self];
    }
    
    [_btnGo setEnabled:NO];
    [_btnGo setAlpha:0.5];

}

- (void)viewDidAppear:(BOOL)animated {
    /*[_viewBlock setHidden:YES];
    //_viewBlock.hidden = YES;
    [_pkrAge setHidden:NO];*/
}

#pragma mark - UIPickerDataSource

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return number;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark - UIPickerViewDelegate

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = [NSString stringWithFormat:@"%ld", (long)row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    age = (int) row;
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"trigger");
    [textField resignFirstResponder];
    name = [textField text];
    if ([textField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please input a name."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [_btnGo setEnabled:NO];
        [_btnGo setAlpha:0.5];
    } else {
        [_btnGo setEnabled:YES];
        [_btnGo setAlpha:1.0];
    }
    return YES;
}

#pragma mark - Navigation

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"sgGo"]) {
        [counter setName:name andAge:age];
        [counter save];
    }
}

@end
