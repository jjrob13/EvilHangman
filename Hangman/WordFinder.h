//
//  WordFinder.h
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WORDSFILE @"small.plist"

@interface WordFinder : NSObject

@property (strong) NSMutableArray *wordArray;
@property int lengthOfWord;

-(void)initWithContentsOfFile:(NSString *)filePath;

-(void)initWithLengthOfWord:(int)len;
@end
