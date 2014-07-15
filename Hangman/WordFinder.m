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
        self.combinations = [CombinationGenerator getAllCombinationsForLength:length];
        
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

    //There are 2^n possible combinations of character locations for a given character and word.
    //n is the length of the word.  n choose 0 + n choose 1 + n choose 2 + ... + n choose n yields
    //the 2^n figure that I previously stated.
    EquivalentPartition *largestPartition;
    
    //largestPartition will be populated initially with the EP for the case where the letter is not present in the word
    largestPartition = [[EquivalentPartition alloc] initWithCharacter:character andIndices:nil andWords:self.remainingWordList];
    
    
    //create equivalentPartitions for all cases and select the largest
    for (NSArray* singleIndexCombination in self.combinations) {
        EquivalentPartition *tempPartition = [[EquivalentPartition alloc] initWithCharacter:character andIndices:singleIndexCombination andWords:self.remainingWordList];
        
        //Choose the larger of the partitions
        if (tempPartition.sizeOfPartition >= largestPartition.sizeOfPartition) {
            largestPartition = tempPartition;
        }
    }
    
    //update current state of guessed word and remaining word list.
    for (NSNumber *indexOfChar in largestPartition.indices) {
        [self.currentStateOfGuessedWord replaceCharactersInRange:NSMakeRange([indexOfChar integerValue], 1) withString:[NSString stringWithFormat:@"%c", character]];
    }
    
    self.remainingWordList = largestPartition.wordsInEquivalentPartition;
    
    
    //checking to see if character was "added" to the word
    if (largestPartition.indices != nil) {
        return false;
    }
    
    return true;
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
@end
