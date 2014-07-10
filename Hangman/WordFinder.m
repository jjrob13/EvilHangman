//
//  WordFinder.m
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "WordFinder.h"

@implementation WordFinder

-(void)initWithContentsOfFile:(NSString *)fileName {
    
    
    NSString *fullPathToFile = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
    
    self.words = [[NSMutableArray alloc] initWithContentsOfFile:fullPathToFile];
    
}



@end
