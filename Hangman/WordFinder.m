//
//  WordFinder.m
//  Hangman
//
//  Created by John Robertson on 7/10/14.
//  Copyright (c) 2014 John Robertson. All rights reserved.
//

#import "WordFinder.h"

@implementation WordFinder



-(id)initWithLengthOfWord:(int)length {
    self = [self initWithContentsOfFile:WORDSFILE];

    
    if (self) {
        //Populate word array
        self.lengthOfWord = length;
        
        self.currentStateOfGuessedWord = [[NSMutableString alloc] init];
        
        //fill currentStateOfGuessedWord with underscores
        for (int i = 0; i < self.lengthOfWord; i++) {
            [self.currentStateOfGuessedWord appendString:@"_"];
        }
        
        //delete all words that do not have correct length
        NSMutableArray *itemsToRemove = [[NSMutableArray alloc] init];
        for(NSString* word in self.remainingWordList){
            if (word.length != self.lengthOfWord) {
                
                //populate itemsToRemove with the words of incorrect length
                [itemsToRemove addObject:word];
            }
            
        }
        
        //Use itemsToRemove to delete words of incorrect length
        [self.remainingWordList removeObjectsInArray:itemsToRemove];
        
        
        //populate the combinations array
        //self.combinations = [CombinationGenerator getAllCombinationsForLength:length];
        
    }
    return self;
}


-(id)initWithContentsOfFile:(NSString *)fileName {
    self = [self init];
    if (self) {
        

        NSString *fullPathToFile = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
        
        self.remainingWordList = [[NSMutableArray alloc] initWithContentsOfFile:fullPathToFile];
        self.previouslyGuessedCharacters = [[NSMutableString alloc] init];
        
    }
    return self;
}



-(BOOL)updateWordsListWithLargestEquivalentPartitionForCharacter:(char)character{

    NSMutableArray *equivalentPartitionArray = [[NSMutableArray alloc] init];
    
    for (NSString* word in self.remainingWordList) {
        //find indices that the desired characters are at
        NSMutableArray *indicesForSingleWord = [[NSMutableArray alloc] init];
        for (int i = 0; i < word.length; i++) {
            if ([word characterAtIndex:i] == character) {
                [indicesForSingleWord addObject:[[NSNumber alloc] initWithInt:i]];
            }
        }
        
        //check to see if the EquivalentPartition with the desired index already exists in array
        BOOL createNewEqPartition = YES;
        
        for (EquivalentPartition* EP in equivalentPartitionArray) {
            if ([self array:EP.indices hasTheSameContentsAsArray:indicesForSingleWord]) {
                createNewEqPartition = NO;
                
                //add word to the equivalent partition with the correct indices
                [EP addWord:word];
                
            }
        }
        
        //if a new EP needs to be created, create it and add the word
        if (createNewEqPartition) {
            
            EquivalentPartition *partitionToBeAdded = [[EquivalentPartition alloc] initWithCharacter:character andIndices:indicesForSingleWord];
            //add the word to the partition
            [partitionToBeAdded addWord:word];
            
            //add the partition to the array of equivalent partitions
            [equivalentPartitionArray addObject:partitionToBeAdded];
            
        }
        
    
    }
    
    
    //find the Largest Partition in the equivalentPartition and update the remainingWordsList accordingly
    
    //get first equivalent partition
    EquivalentPartition *largestPartition = [equivalentPartitionArray objectAtIndex:0];
    
    for (EquivalentPartition *EP in equivalentPartitionArray) {
        if (largestPartition.sizeOfPartition < EP.sizeOfPartition) {
            largestPartition = EP;
        }
    }
    
    
    
    self.remainingWordList = largestPartition.wordsInEquivalentPartition;
    
    //BOOL to determine whether or not the character was added
    BOOL result = NO;

    //if the size of the indices partition does not equal zero, a character was added
    if (largestPartition.indices.count != 0) {
        result = YES;
        
        
        //update current state of guessed word and remaining word list.
        for (NSNumber *indexOfChar in largestPartition.indices) {
            [self.currentStateOfGuessedWord replaceCharactersInRange:NSMakeRange([indexOfChar integerValue], 1) withString:[NSString stringWithFormat:@"%c", character]];
        }
        
    }
    
    return result;
}



-(BOOL)string:(NSString*)str ContainsCharacter:(char)character {
    
    BOOL result = NO;
    for (int i = 0; i < [str length]; i++) {
        if ([str characterAtIndex:i] == character) {
            result = YES;
            break;
        }
    }
    
    return result;
}


//returns the index of where the new character was placed or nil
//if the character is not included
-(BOOL)updateListForNewCharacter:(char)character {
    
    return [self updateWordsListWithLargestEquivalentPartitionForCharacter:character];
}

-(BOOL)userWinsTheGame {
    BOOL result = NO;
    if (![self string:self.currentStateOfGuessedWord ContainsCharacter:'_']) {
        result = YES;
    }
    
    return result;
}

-(BOOL)allLettersInWordHaveBeenGuessedUsingWord:(NSString *)word {
    BOOL result = YES;
    //check to see if each character
    for (int i = 0; i < word.length; i++) {
        if (![self userHasPreviouslyGuessedCharacter:[word characterAtIndex:i]]) {
            result = NO;
            break;
        }
    }
    
    return result;
}

-(BOOL)userHasPreviouslyGuessedCharacter:(char)character {
    BOOL result = NO;
    for (int i = 0; i < self.previouslyGuessedCharacters.length; i++) {
        if (character == [self.previouslyGuessedCharacters characterAtIndex:i]) {
            result = true;
            break;
        }
    }
    
    return result;
}

-(NSString *)getRandomRemainingWord {
    int indexOfWordToReturn = round(arc4random() % self.remainingWordList.count);
    
    return [self.remainingWordList objectAtIndex:indexOfWordToReturn];
}

-(BOOL)array:(NSArray*)array1 hasTheSameContentsAsArray:(NSArray*)array2 {
    BOOL result = YES;
    if (array1.count != array2.count) {
        result = NO;
    }else {
        for (int i = 0; i < array1.count; i++) {
            if ([[array1 objectAtIndex:i] integerValue] != [[array2 objectAtIndex:i] integerValue]) {
                result = NO;
                break;
            }
        }
    }
    
    return result;
}
@end
