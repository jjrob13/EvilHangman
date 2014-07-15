//
//  CombinationGenerator.h
//  Hangman
//
//  Created by John Robertson on 7/14/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CombinationGenerator : NSObject
+(NSArray*)getAllCombinationsForLength:(int)len;
@end
