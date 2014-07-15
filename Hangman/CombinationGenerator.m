//
//  CombinationGenerator.m
//  Hangman
//
//  Created by John Robertson on 7/14/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "CombinationGenerator.h"

@implementation CombinationGenerator

+(NSArray *)getAllCombinationsForLength:(int)len {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 1; i <= len; i++) {
        [result addObjectsFromArray:[self getCombinationsForN:len chooseM:i]];
    }
    
    return result;
}


+(NSMutableArray *)getCombinationsForN:(int)n chooseM:(int)m {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int     k = m, i, j, c;
    
    /* i goes through all n-bit numbers */
    
    for (i=0; i<(1<<n); i++) {
        
        /* masking the j'th bit as j goes through all the bits,
         * count the number of 1 bits.  this is called finding
         * a population count.
         */
        for (j=0,c=0; j<32; j++) if (i & (1<<j)) c++;
        
        /* if that number is equal to k, print the combination... */
        
        if (c == k) {
            NSMutableArray *singleCombination = [[NSMutableArray alloc] init];
            /* by again going through all the bits indices,
             * printing only the ones with 1-bits
             */
            
            for (j=0;j<32; j++) if (i & (1<<j)) {
                [singleCombination addObject:[[NSNumber alloc] initWithInt:j]];
            }
            [result addObject:singleCombination];
        }
    }
    
    return result;
}

@end
