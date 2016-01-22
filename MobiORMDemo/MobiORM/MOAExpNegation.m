//
//  MOAExpNegation.m
//  Mobi ORM
//

#import "MOAExpNegation.h"

@interface MOAExpNegation ()

@property MOAExp *expression;

@end

@implementation MOAExpNegation

+ (MOAExp *)getNegatedExpressionFrom:(MOAExp *)exp {
    MOAExpNegation *result = [[MOAExpNegation alloc] init];
    result.expression = exp;
    return result;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:LP];
    [result appendString:MINUS];
    [result appendString:LP];
    
    [result appendString:[self.expression build]];
    
    [result appendString:RP];
    [result appendString:RP];
    
    return result;
}

- (NSArray *)getParameters {
    return [self.expression getParameters];
}


@end
