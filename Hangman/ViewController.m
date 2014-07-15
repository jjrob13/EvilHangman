//
//  ViewController.m
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.wordFinder = [[WordFinder alloc] initWithLengthOfWord:5];
    
    [self updateWordLabel];
  
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)characterGuessed:(UIButton*)sender {
    if (![sender isHidden]) {
        [self.wordFinder updateListForNewCharacter:[sender.titleLabel.text characterAtIndex:0]];
        [sender setHidden:YES];
        [self updateWordLabel];

    }
}


-(void)updateWordLabel {
    
    self.onScreenWordLabel.text = @"";
    
    for (int i = 0; i < self.wordFinder.lengthOfWord; i++) {
        ;
        self.onScreenWordLabel.text = [self.onScreenWordLabel.text stringByAppendingString:[NSString stringWithFormat:@" %c", [self.wordFinder.currentStateOfGuessedWord characterAtIndex:i]]];
        
    }
}
@end
