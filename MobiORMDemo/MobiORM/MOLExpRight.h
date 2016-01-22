//
//  MOLExpRight.h
//  Mobi ORM
//
//  Represents logical expression with one, right-sided argument, like:
//  NOT A
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOLExp class !!!
//

#import "MOLExp.h"

@interface MOLExpRight : MOLExp

+ (MOLExp *)lExpWithOperator:(NSString *)operator
               forExpression:(id<MOExpression>)exp
                 parentheses:(BOOL)parentheses;

- (id)initWithOperator:(NSString *)operator expression:(id<MOExpression>)exp;

@end
