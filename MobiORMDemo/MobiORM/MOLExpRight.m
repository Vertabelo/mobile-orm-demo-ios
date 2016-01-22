//
//  MOLExpRight.m
//  Mobi ORM
//

#import "MOLExpRight.h"
#import "MOLExpParentheses.h"

@interface MOLExpRight ()

@property id<MOExpression> expression;
@property NSString *operator;

@end

@implementation MOLExpRight

+ (MOLExp *)lExpWithOperator:(NSString *)operator
               forExpression:(id<MOExpression>)exp
                 parentheses:(BOOL)parentheses {
    
    MOLExpRight *result = [[MOLExpRight alloc] initWithOperator:operator
                                                     expression:exp];
    
    if (parentheses) {
        return [MOLExpParentheses getInParenthesesExpression:result];
    }
    return result;
}

- (id)initWithOperator:(NSString *)operator expression:(id<MOExpression>)exp {
    self = [super init];
    
    if (self) {
        self.operator = operator;
        self.expression = exp;
    }
    return self;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:self.operator];
    [result appendString:[self.expression build]];
    
    return result;
}

- (NSArray *)getParameters {
    return [self.expression getParameters];
}

@end
