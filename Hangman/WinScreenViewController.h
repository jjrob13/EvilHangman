//
//  WinScreenViewController.h
//  Hangman
//
//  Created by John Robertson on 7/15/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WinScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *correctWordLabel;
@property (strong, nonatomic) IBOutlet UILabel *remainingGuessesLabel;

@property int remainingGuesses;
@property NSString *correctWord;

@property UIFont *fontForWord;
- (IBAction)playAgainButtonPressed:(id)sender;

@end
