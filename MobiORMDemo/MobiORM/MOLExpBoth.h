//
//  MOLExpBoth.h
//  Mobi ORM
//
//  Represents two argument logical expression, like: A <> B, A = B, A AND B
//
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOLExp class !!!
//

#import "MOLExp.h"

@interface MOLExpBoth : MOLExp

+ (MOLExp *)lExpWithLeft:(id<MOExpression>)left operator:(NSString *)operator
                   right:(id<MOExpression>)right parentheses:(BOOL)parentheses;

- (id)initWithLeft:(id<MOExpression>)left operator:(NSString *)operator
             right:(id<MOExpression>)right;

@end
