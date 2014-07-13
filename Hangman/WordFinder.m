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



-(NSNumber *)updateWordsListWithLargestEquivalentPartitionForCharacter:(char)character{
    //Create an array of lengths with indices for each character position in word
    //as well as case where word does not contain character (Length of word + 1 indices)
    
    NSMutableArray *equivalentPartitionSizeArray = [[NSMutableArray alloc] initWithCapacity:(self.lengthOfWord + 1)];
    

    //fill the equivalentPartitionSizeArray with the sizes of the Equivalent Partitions for the cases
    //of having the specified character at each index
    for (int i = 0; i < self.lengthOfWord; i++) {
        [equivalentPartitionSizeArray insertObject:[self getNumberOfWordsContainingCharacter:character atIndex:i] atIndex:i];
    }
    
    
    //index of self.lengthOfWord corresponds to the word not including the char
    //calculate number of words without the specified character
    [equivalentPartitionSizeArray insertObject:[self getNumberOfWordsNotContainingCharacter:character] atIndex:self.lengthOfWord];
    
    
    //array should be filled with the sizes of each of the equivalent partitions
    
    //find which case yields the largest equivalent partition
    int largestIndex = 0;
    //set largest equiv partition to be -1 initially
    NSNumber *sizeOfLargestEquivalentPartition = [[NSNumber alloc] initWithInt:-1];
    
    
    //less than or equal to ensures the case of the word not containing the character is included
    for (int i = 0; i <= self.lengthOfWord; i++) {
        if ([[equivalentPartitionSizeArray objectAtIndex:i] integerValue] > [sizeOfLargestEquivalentPartition integerValue]) {
            sizeOfLargestEquivalentPartition = [equivalentPartitionSizeArray objectAtIndex:i];
            largestIndex = i;
        }
    }
    
    
    //update the wordArray property to the new largest Equivalent Partition by using the largestIndex variable
    NSMutableArray *updatedWordArray;
    
    //if largest index == self.lengthOfWord the largest EP is for the case in which
    //the word does not contain the character
    
    
    //result is the index of where the character should be placed
    //or nil if the character should not be included
    NSNumber *result = nil;
    
    //do not change nil in the first case because it should not
    //be the character should not be added to the screen
    if (largestIndex == self.lengthOfWord) {
        updatedWordArray = [[NSMutableArray alloc] initWithArray:[self getEquivalentPartitionForWordsNotContainingCharacter:character]];
    }else {
        updatedWordArray = [[NSMutableArray alloc] initWithArray:[self getEquivalentPartitionForWordsContainingCharacter:character atIndex:largestIndex]];
        result = [[NSNumber alloc] initWithInt:largestIndex];
    }
    
    
    //assign the updatedWordArray to the wordArray property
    self.remainingWordList = updatedWordArray;
    
    [self.previouslyGuessedCharacters appendString:[NSString stringWithFormat:@"%c", character]];
    character;
    
    //return the value of where the character should be displayed
    //or nil if it should not be displayed.
    
    return result;
    
}


-(NSNumber*)getNumberOfWordsContainingCharacter:(char)character atIndex:(int)index {
    int numberOfWordsWithCharAtCorrectIndex = 0;
    
    //iterates through wordArray and counts the number
    //of words with the desired char at the desired index
    for(NSString *word in self.remainingWordList) {
        if ([word characterAtIndex:index] == character && [self word:word DoesNotHaveCharacter:character ExceptAtIndex:index]) {
            numberOfWordsWithCharAtCorrectIndex++;
        }
    }
    
    return [[NSNumber alloc] initWithInt:numberOfWordsWithCharAtCorrectIndex];
}


-(NSNumber *)getNumberOfWordsNotContainingCharacter:(char)character {
    int numberOfWordsWithoutChar = 0;
    
    for(NSString *word in self.remainingWordList) {
        if (![self string:word ContainsCharacter:character]) {
            numberOfWordsWithoutChar++;
        }
    }
    
    return [[NSNumber alloc] initWithInt:numberOfWordsWithoutChar];
    
}

-(NSMutableArray*)getEquivalentPartitionForWordsContainingCharacter:(char)character atIndex:(int)index {
    NSMutableArray *resultingPartition = [[NSMutableArray alloc] init];
    
    //add words with the desired character at the desired index
    for (NSString *word in self.remainingWordList) {
        
        //This if statement passes if the word has the character at th correct index
        //and the word does not have the character at any other index
        if ([word characterAtIndex:index] == character && [self word:word DoesNotHaveCharacter:character ExceptAtIndex:index]) {
            [resultingPartition addObject:word];
        }
    }
    
    
    
    
    //return resultingPartition
    return resultingPartition;
}

-(NSMutableArray*)getEquivalentPartitionForWordsNotContainingCharacter:(char)character {
    NSMutableArray *resultingPartition = [[NSMutableArray alloc] init];
    
    for(NSString *word in self.remainingWordList) {
        if (![self string:word ContainsCharacter:character]) {
            [resultingPartition addObject:word];
        }
    }
    
    return resultingPartition;
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
-(NSNumber *)updateListForNewCharacter:(char)character {
    
    return [self updateWordsListWithLargestEquivalentPartitionForCharacter:character];
}


//This method checks to see if a character is repeated in a word
-(BOOL)word:(NSString*)word DoesNotHaveCharacter:(char)character ExceptAtIndex:(int)index {
    BOOL result = YES;
    for (int i = 0; i < word.length; i++) {
        if ([word characterAtIndex:i] == character && i != index) {
            result = NO;
        }
    }
    
    return result;
    
    
}

-(BOOL)userWinsTheGame {
    BOOL result = NO;
    if (self.remainingWordList.count == 1 && [self allLettersInWordHaveBeenGuessedUsingWord:self.remainingWordList[0]]) {
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
@end
