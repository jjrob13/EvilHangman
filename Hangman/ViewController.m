//
//  ViewController.m
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "ViewController.h"
#import "WordFinder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    WordFinder *wordController = [[WordFinder alloc] initWithLengthOfWord:4];
    
    NSNumber *index = [wordController updateListForNewCharacter:'R'];
    index = [wordController updateListForNewCharacter:'B'];
    index = [wordController updateListForNewCharacter:'G'];
    index = [wordController updateListForNewCharacter:'I'];
    index = [wordController updateListForNewCharacter:'A'];
    index = [wordController updateListForNewCharacter:'E'];
    index = [wordController updateListForNewCharacter:'O'];
    index = [wordController updateListForNewCharacter:'U'];
    index = [wordController updateListForNewCharacter:'Q'];
    index = [wordController updateListForNewCharacter:'H'];
    index = [wordController updateListForNewCharacter:'P'];
    index = [wordController updateListForNewCharacter:'L'];
    index = [wordController updateListForNewCharacter:'T'];
    index = [wordController updateListForNewCharacter:'S'];
    index = [wordController updateListForNewCharacter:'C'];
    index = [wordController updateListForNewCharacter:'D'];
    index = [wordController updateListForNewCharacter:'F'];
    index = [wordController updateListForNewCharacter:'N'];
    index = [wordController updateListForNewCharacter:'K'];
    NSLog(@"%d", [wordController userWinsTheGame]);

    index = [wordController updateListForNewCharacter:'J'];

    NSLog(@"%d", [wordController userWinsTheGame]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
