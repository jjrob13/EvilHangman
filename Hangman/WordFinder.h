//
//  WordFinder.h
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordFinder : NSObject

@property (strong) NSMutableArray *words;

-(void)initWithContentsOfFile:(NSString *)filePath;
@end
