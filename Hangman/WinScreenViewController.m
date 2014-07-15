//
//  WinScreenViewController.m
//  Hangman
//
//  Created by John Robertson on 7/15/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "WinScreenViewController.h"

@implementation WinScreenViewController


-(void)viewDidLoad {
    self.correctWordLabel.text = self.correctWord;
    
    self.remainingGuessesLabel.text = [NSString stringWithFormat:@"You had %i guesses remaining", self.remainingGuesses];
}
- (IBAction)playAgainButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
