//
//  MOAExpOperator.m
//  Mobi ORM
//

#import "MOAExpOperator.h"
#import "MOAExpParentheses.h"

@interface MOAExpOperator ()

@property MOAExp *left;
@property MODbOperator operator;
@property MOAExp *right;

- (NSString *)stringFromOperator;

@end

@implementation MOAExpOperator

- (NSString *)stringFromOperator {
    switch (self.operator) {
        case ADD: {
            return @" + ";
        }
        case SUB: {
            return @" - ";
        }
        case MUL: {
            return @" * ";
        }
        case DIV: {
            return @" / ";
        }
    }
}

+ (MOAExp *)aExpWithLeft:(MOAExp *)left operator:(MODbOperator)operator
                   right:(MOAExp *)right parentheses:(BOOL)parentheses {
    MOAExpOperator *result = [[MOAExpOperator alloc] init];
    
    result.left = left;
    result.operator = operator;
    result.right = right;
    
    if (parentheses) {
        return [MOAExpParentheses getInParenthesesExpression:result];
    }
    return result;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:[self.left build]];
    [result appendString:[self stringFromOperator]];
    [result appendString:[self.right build]];

    return result;
}

- (NSMutableArray *)getParameters {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObjectsFromArray:[self.left getParameters]];
    [parameters addObjectsFromArray:[self.right getParameters]];
    return parameters;
}



@end
