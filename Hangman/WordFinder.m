//
//  WordFinder.m
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "WordFinder.h"

@implementation WordFinder

-(void)initWithLengthOfWord:(int)length {
    //Populate word array
    [self initWithContentsOfFile:WORDSFILE];
    self.lengthOfWord = length;
    
    //delete all words that do not have correct length
    NSMutableArray *itemsToRemove = [[NSMutableArray alloc] init];
    for(NSString* word in self.wordArray){
        if (word.length != self.lengthOfWord) {
            
            //populate itemsToRemove with the words of incorrect length
            [itemsToRemove addObject:word];
        }
        
    }
    
    //Use itemsToRemove to delete words of incorrect length
    [self.wordArray removeObjectsInArray:itemsToRemove];
    
    
    
}


-(void)initWithContentsOfFile:(NSString *)fileName {
    
    
    NSString *fullPathToFile = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
    
    self.wordArray = [[NSMutableArray alloc] initWithContentsOfFile:fullPathToFile];
    
}




@end
