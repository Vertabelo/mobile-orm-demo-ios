//
//  MOAExpOperator.h
//  Mobi ORM
//
//  Represents an arithmetical expression with operator, like A + B
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOAExp class !!!
//

#import "MOAExp.h"

@interface MOAExpOperator : MOAExp

+ (MOAExp *)aExpWithLeft:(MOAExp *)left operator:(MODbOperator)operator
                   right:(MOAExp *)right parentheses:(BOOL)parentheses;

@end
