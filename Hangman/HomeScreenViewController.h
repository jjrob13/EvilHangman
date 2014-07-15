//
//  HomeScreenViewController.h
//  Hangman
//
//  Created by John Robertson on 7/15/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface HomeScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *difficultySelect;

- (IBAction)wordLengthSliderChanged:(UISlider*)sender;

@property (strong, nonatomic) IBOutlet UILabel *wordLengthLabel;

@end
