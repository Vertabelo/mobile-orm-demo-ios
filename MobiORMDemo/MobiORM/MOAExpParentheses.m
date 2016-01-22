//
//  MOAExpParentheses.m
//  Mobi ORM
//

#import "MOAExpParentheses.h"

@interface MOAExpParentheses ()

@property MOAExp *expression;

@end

@implementation MOAExpParentheses

+ (MOAExp *)getInParenthesesExpression:(MOAExp *)exp {
    MOAExpParentheses *result = [[MOAExpParentheses alloc] init];
    result.expression = exp;
    return result;
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
