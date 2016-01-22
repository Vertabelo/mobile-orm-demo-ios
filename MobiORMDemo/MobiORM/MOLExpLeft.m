//
//  MOLExpLeft.m
//  Mobi ORM
//

#import "MOLExpLeft.h"
#import "MOLExpParentheses.h"

@interface MOLExpLeft ()

@property id<MOExpression> expression;
@property NSString *operator;

@end

@implementation MOLExpLeft

+ (MOLExp *)lExpWithExpression:(id<MOExpression>)exp
                      operator:(NSString *)operator
            parentheses:(BOOL)parentheses {
    MOLExp *result = [[MOLExpLeft alloc] initWithExpression:exp
                                                   operator:operator];
    
    if (parentheses) {
        return [MOLExpParentheses getInParenthesesExpression:result];
    }
    return result;
}

- (id)initWithExpression:(id<MOExpression>)exp operator:(NSString *)operator {
    self = [super init];
    
    if (self) {
        self.expression = exp;
        self.operator = operator;
    }
    return self;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:[self.expression build]];
    [result appendString:self.operator];
    
    return result;
}

- (NSArray *)getParameters {
    return [self.expression getParameters];
}

@end
