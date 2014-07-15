//
//  HomeScreenViewController.m
//  Hangman
//
//  Created by John Robertson on 7/15/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "HomeScreenViewController.h"

@implementation HomeScreenViewController

- (IBAction)wordLengthSliderChanged:(UISlider*)sender {
    int roundedValue = round(sender.value);
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%i", roundedValue];
    sender.value = (float)roundedValue;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueToGameScreen"]) {
        ViewController *dest = segue.destinationViewController;
        dest.guessesRemaining = (15 - (self.difficultySelect.selectedSegmentIndex * 5));
        dest.userSelectedWordLength = [self.wordLengthLabel.text floatValue];
        
    }
}
@end
