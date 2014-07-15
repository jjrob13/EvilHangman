//
//  LossScreenViewController.h
//  Hangman
//
//  Created by John Robertson on 7/15/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LossScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *correctWordLabel;

@property NSString *correctWord;
- (IBAction)playAgainButton:(id)sender;

@end
