//
//  WordFinder.h
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WORDSFILE @"words.plist"

@interface WordFinder : NSObject

@property (strong) NSMutableArray *remainingWordList;
@property (strong) NSMutableString *currentStateOfGuessedWord;
@property int lengthOfWord;
@property NSMutableString *previouslyGuessedCharacters;

-(id)initWithLengthOfWord:(int)len;

-(NSNumber*)updateListForNewCharacter:(char)character;

-(BOOL)userWinsTheGame;
@end
