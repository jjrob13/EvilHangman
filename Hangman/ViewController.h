//
//  ViewController.h
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordFinder.h"

@interface ViewController : UIViewController
- (IBAction)characterGuessed:(UIButton*)sender;
@property (strong, nonatomic) IBOutlet UILabel *onScreenWordLabel;
@property WordFinder *wordFinder;
@end
