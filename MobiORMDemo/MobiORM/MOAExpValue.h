//
//  MOAExpValue.h
//  Mobi ORM
//
//  Represents an arithmetical expression being a value, for example:
//  5, "word", 42.42
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOAExp class !!!
//

#import "MOAExp.h"
#import "MOValue.h"

@interface MOAExpValue : MOAExp

+ (MOAExp *)aExpWithValue:(MOValue *)val;

@end
