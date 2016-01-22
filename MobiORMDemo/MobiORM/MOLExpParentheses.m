//
//  MOLExpParentheses.m
//  Mobi ORM
//

#import "MOLExpParentheses.h"

@interface MOLExpParentheses ()

@property MOLExp *expression;

@end

@implementation MOLExpParentheses

+ (MOLExp *)getInParenthesesExpression:(MOLExp *)exp {
    return [[MOLExpParentheses alloc] initWithExpression:exp];
}

- (id)initWithExpression:(MOLExp *)exp {
    self = [super init];
    
    if (self) {
        self.expression = exp;
    }
    return self;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:LP];
    [result appendString:[self.expression build]];
    [result appendString:RP];
    
    return result;
}

- (NSArray *)getParameters {
    return [self.expression getParameters];
}

@end
