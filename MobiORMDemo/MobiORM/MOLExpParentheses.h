//
//  MOLExpParentheses.h
//  Mobi ORM
//
//  Represents a logical expression being another expression
//  surrounded by parentheses, for example: (A = B), (A IS NOT NULL)
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOLExp class !!!
//

#import "MOLExp.h"

@interface MOLExpParentheses : MOLExp

+ (MOLExp *)getInParenthesesExpression:(MOLExp *)exp;

- (id)initWithExpression:(MOLExp *)exp;

@end
