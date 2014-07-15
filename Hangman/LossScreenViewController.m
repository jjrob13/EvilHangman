//
//  LossScreenViewController.m
//  Hangman
//
//  Created by John Robertson on 7/15/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "LossScreenViewController.h"

@implementation LossScreenViewController

-(void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    self.correctWordLabel.text = self.correctWord;
}
- (IBAction)playAgainButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
