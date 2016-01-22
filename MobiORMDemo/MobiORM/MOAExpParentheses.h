//
//  MOAExpParentheses.h
//
//  Represents an arithmetical expression being another expression
//  surrounded by parentheses, for example: (A).
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOAExp class !!!
//

#import "MOAExp.h"

@interface MOAExpParentheses : MOAExp

+ (MOAExp *)getInParenthesesExpression:(MOAExp *)exp;

@end
