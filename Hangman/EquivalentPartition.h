//
//  EquivalentPartition.h
//  Hangman
//
//  Created by John Robertson on 7/12/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquivalentPartition : NSObject

//array of NSNumbers that are used to identify which indices the character is at
@property NSArray *indices;

@property char characterForEquivalentPartition;

@property int sizeOfPartition;

@property NSMutableArray *wordsInEquivalentPartition;

-(id)initWithCharacter:(char)character andIndices:(NSArray*)indices andWords:(NSArray*)words;

@end
