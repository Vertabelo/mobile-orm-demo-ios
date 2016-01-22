//
//  MOLExpLeft.h
//  Mobi ORM
//
//  Represents logical expression with one, left-sided argument, like:
//  A IS NOT NULL
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOLExp class !!!
//

#import "MOLExp.h"

@interface MOLExpLeft : MOLExp

+ (MOLExp *)lExpWithExpression:(id<MOExpression>)exp
                      operator:(NSString *)operator
                   parentheses:(BOOL)parentheses;

- (id)initWithExpression:(id<MOExpression>)exp operator:(NSString *)operator;

@end
