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
    
    
    
    WordFinder *wordController = [[WordFinder alloc] initWithLengthOfWord:5];
    
    [wordController updateListForNewCharacter:'R'];
    [wordController updateListForNewCharacter:'B'];
    [wordController updateListForNewCharacter:'G'];
    [wordController updateListForNewCharacter:'I'];
    [wordController updateListForNewCharacter:'A'];
    [wordController updateListForNewCharacter:'E'];
    [wordController updateListForNewCharacter:'O'];
    [wordController updateListForNewCharacter:'U'];
    [wordController updateListForNewCharacter:'Q'];
    [wordController updateListForNewCharacter:'H'];
    [wordController updateListForNewCharacter:'P'];
    [wordController updateListForNewCharacter:'L'];
    [wordController updateListForNewCharacter:'T'];
    [wordController updateListForNewCharacter:'S'];
    [wordController updateListForNewCharacter:'C'];
    [wordController updateListForNewCharacter:'D'];
    [wordController updateListForNewCharacter:'F'];
    [wordController updateListForNewCharacter:'N'];
    [wordController updateListForNewCharacter:'K'];
    NSLog(@"%d", [wordController userWinsTheGame]);

    [wordController updateListForNewCharacter:'J'];

    NSLog(@"%d", [wordController userWinsTheGame]);
    [wordController updateListForNewCharacter:'Z'];
    
    [wordController updateListForNewCharacter:'M'];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
