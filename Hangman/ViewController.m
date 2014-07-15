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
    
    self.wordFinder = [[WordFinder alloc] initWithLengthOfWord:self.userSelectedWordLength];
    
    //change font size depending on length of word
    self.onScreenWordLabel.font = [UIFont systemFontOfSize:(29 - (.6 * self.wordFinder.lengthOfWord))];
    self.navigationController.navigationBarHidden = YES;

    
    [self updateScreen];
  
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)characterGuessed:(UIButton*)sender {
    if (![sender isHidden]) {

        
        
        //check to see if word was "added" to the word
        if ([self.wordFinder updateListForNewCharacter:[sender.titleLabel.text characterAtIndex:0]]) {
            self.guessesRemaining--;
        }
        
        [sender setHidden:YES];
        
        //check for a win
        if ([self.wordFinder userWinsTheGame]) {
            [self performSegueWithIdentifier:@"segueToWin" sender:self];
            return;
        }
        
        
        [self updateScreen];

    }
}


-(void)updateScreen {
    
    if (self.guessesRemaining > 0) {
    
        self.onScreenWordLabel.text = @"";
        self.guessesRemainingLabel.text = [NSString stringWithFormat:@"%i", self.guessesRemaining];
        for (int i = 0; i < self.wordFinder.lengthOfWord; i++) {
            ;
            self.onScreenWordLabel.text = [self.onScreenWordLabel.text stringByAppendingString:[NSString stringWithFormat:@" %c", [self.wordFinder.currentStateOfGuessedWord characterAtIndex:i]]];
            
        }
    }else {
        [self performSegueWithIdentifier:@"segueToLoss" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToLoss"]) {
        LossScreenViewController *dest = segue.destinationViewController;
        dest.correctWord = [self.wordFinder getRandomRemainingWord];
    }else if([segue.identifier isEqualToString:@"segueToWin"]) {
        WinScreenViewController *dest = segue.destinationViewController;
        dest.correctWord = self.wordFinder.currentStateOfGuessedWord;
        dest.remainingGuesses = self.guessesRemaining;
    }
}
@end
