//
//  MOAExpNegation.h
//  Mobi ORM
//
//  Represents an arithmetical expression being a negation of another expression.
//  As SQL query, it looks (-(A))
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOAExp class !!!
//

#import "MOAExp.h"

@interface MOAExpNegation : MOAExp

+ (MOAExp *)getNegatedExpressionFrom:(MOAExp *)exp;

@end
