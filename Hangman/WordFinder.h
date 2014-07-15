//
//  WordFinder.h
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EquivalentPartition.h"
#import "CombinationGenerator.h"
#define WORDSFILE @"words.plist"

@interface WordFinder : NSObject

@property (strong) NSMutableArray *remainingWordList;
@property (strong) NSMutableString *currentStateOfGuessedWord;
@property int lengthOfWord;
@property NSMutableString *previouslyGuessedCharacters;
@property NSArray *combinations;
-(id)initWithLengthOfWord:(int)len;


//returns whether or not the new character is in the word
-(BOOL)updateListForNewCharacter:(char)character;

-(BOOL)userWinsTheGame;

-(NSString*)getRandomRemainingWord;
@end
