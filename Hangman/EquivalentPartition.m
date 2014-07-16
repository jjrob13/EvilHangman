
//  EquivalentPartition.m
//  Hangman
//
//  Created by John Robertson on 7/12/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "EquivalentPartition.h"

@implementation EquivalentPartition

-(id)initWithCharacter:(char)character andIndices:(NSArray *)indices andWords:(NSArray *)words {
    if (self = [self initWithCharacter:character andIndices:indices]) {
        
        self.wordsInEquivalentPartition = [self getWordsWithCharacter:self.characterForEquivalentPartition atIndices:indices fromWordList:words];
        
        self.sizeOfPartition = [self.wordsInEquivalentPartition count];
    }
    
    return self;
}


-(id)initWithCharacter:(char)character andIndices:(NSArray *)indices {
    if (self = [self init]) {
        self.indices = indices;
        self.characterForEquivalentPartition = character;
        self.wordsInEquivalentPartition = [[NSMutableArray alloc] init];
        self.sizeOfPartition = 0;
    }
    
    return self;
}


-(NSMutableArray*)getWordsWithCharacter:(char)character atIndices:(NSArray*)indices fromWordList:(NSArray*)words {
    
    NSMutableArray *resultingArrayOfWords = [[NSMutableArray alloc] init];
    
    //case for when the specified character is not present in the word
    if (indices == nil) {
        
        //check to see if the character is absent from the word
        for (NSString* word in words) {
            if (![self word:word ContainChar:character]) {
                [resultingArrayOfWords addObject:word];
            }
        }
        
        
    }//end if statement
    
    //Case where indices is not nil and the character exists somewhere in the word
    else {
    
        
        for (NSString *word in words) {
            //check to see if the char is at the desired indices, if so add to the resultingArray
            if ([self character:character ExistsOnlyAtIndices:indices InWord:word]) {
                [resultingArrayOfWords addObject:word];
            }
            
            
            
        } //end outer for loop
        
    } //end else statement
    
    return resultingArrayOfWords;
}


-(BOOL)word:(NSString*)word ContainChar:(char) character {
    
    BOOL wordContainsChar = NO;

    for (int i = 0; i < word.length ; i++) {
        if ([word characterAtIndex:i] == character) {
            wordContainsChar = YES;
            break;
        }
    }
    
    return wordContainsChar;
}

-(BOOL)character:(char)character ExistsOnlyAtIndices:(NSArray*)indices InWord:(NSString*)word{
    BOOL charExistsAtCorrectIndices = YES;
    
    //make sure the character exists exclusively at the correct indices
    for(int i = 0; i < word.length; i++) {
        
        //check to see if character is in incorrect position in word or character
        if ([word characterAtIndex:i] == character && ![self index:i IsInIndicesList:indices]) {
            charExistsAtCorrectIndices = NO;
            break;
        }
        
        if ([word characterAtIndex:i] != character && [self index:i IsInIndicesList:indices]) {
            charExistsAtCorrectIndices = NO;
            break;
        }
    }

    
    return charExistsAtCorrectIndices;
}


-(BOOL)index:(int)index IsInIndicesList:(NSArray*)indices {
    BOOL result = NO;
    
    for (NSNumber* indexInList in indices) {
        if ([indexInList integerValue] == index) {
            result = YES;
            break;
        }
    }
    
    return result;
}


-(void)addWord:(NSString *)word {
    [self.wordsInEquivalentPartition addObject:word];
    self.sizeOfPartition++;
}

@end
