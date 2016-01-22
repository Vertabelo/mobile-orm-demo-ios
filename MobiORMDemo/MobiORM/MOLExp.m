//
//  MOLExp.m
//  Mobi ORM
//

#import "MOLExp.h"
#import "MOLExpLeft.h"
#import "MOLExpBoth.h"
#import "MOLExpRight.h"
#import "MOSubselect.h"


@implementation MOLExp

+ (MOLExp *)trueExp {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:1] operator:EQ
                              right:[MOAExp fromInteger:1] parentheses:YES];
}

+ (MOLExp *)falseExp {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:1] operator:EQ
                              right:[MOAExp fromInteger:0] parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left like:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:LIKE right:right
                        parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)exp between:(MOAExp *)left and:(MOAExp *)right {
    MOLExp *between = [MOLExpBoth lExpWithLeft:left operator:AND
                                             right:right parentheses:NO];
    
    return [MOLExpBoth lExpWithLeft:exp operator:BETWEEN right:between
                        parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left isEqualTo:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:EQ right:right
                        parentheses:YES];
}

+ (MOLExp *)boolean:(BOOL)left isEqualTo:(BOOL)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromBool:left] operator:EQ
                              right:[MOAExp fromBool:right] parentheses:YES];
}

+ (MOLExp *)integer:(NSInteger)left isEqualTo:(NSInteger)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:left] operator:EQ
                              right:[MOAExp fromInteger:right] parentheses:YES];
}

+ (MOLExp *)number:(NSNumber *)left isEqualTo:(NSNumber *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:left] operator:EQ
                              right:[MOAExp fromNumber:right] parentheses:YES];
}

+ (MOLExp *)string:(NSString *)left isEqualTo:(NSString *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromString:left] operator:EQ
                              right:[MOAExp fromString:right] parentheses:YES];
}

+ (MOLExp *)date:(NSDate *)left isEqualTo:(NSDate *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromDate:left] operator:EQ
                              right:[MOAExp fromDate:right] parentheses:YES];
}

+ (MOLExp *)data:(NSData *)left isEqualTo:(NSData *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromData:left] operator:EQ
                              right:[MOAExp fromData:right] parentheses:YES];
}

+ (MOLExp *)object:(id)left isEqualTo:(id)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromObject:left] operator:EQ
                              right:[MOAExp fromObject:right] parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left isNotEqualTo:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:NE right:right
                        parentheses:YES];
}

+ (MOLExp *)boolean:(BOOL)left isNotEqualTo:(BOOL)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromBool:left] operator:NE
                              right:[MOAExp fromBool:right] parentheses:YES];
}

+ (MOLExp *)integer:(NSInteger)left isNotEqualTo:(NSInteger)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:left] operator:NE
                              right:[MOAExp fromInteger:right] parentheses:YES];
}

+ (MOLExp *)number:(NSNumber *)left isNotEqualTo:(NSNumber *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:left] operator:NE
                              right:[MOAExp fromNumber:right] parentheses:YES];
}

+ (MOLExp *)string:(NSString *)left isNotEqualTo:(NSString *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromString:left] operator:NE
                              right:[MOAExp fromString:right] parentheses:YES];
}

+ (MOLExp *)date:(NSDate *)left isNotEqualTo:(NSDate *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromDate:left] operator:NE
                              right:[MOAExp fromDate:right] parentheses:YES];
}

+ (MOLExp *)data:(NSData *)left isNotEqualTo:(NSData *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromData:left] operator:NE
                              right:[MOAExp fromData:right] parentheses:YES];
}

+ (MOLExp *)object:(id)left isNotEqualTo:(id)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromObject:left] operator:NE
                              right:[MOAExp fromObject:right] parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left isGreaterThan:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:GT right:right
                        parentheses:YES];
}

+ (MOLExp *)boolean:(BOOL)left isGreaterThan:(BOOL)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromBool:left] operator:GT
                              right:[MOAExp fromBool:right] parentheses:YES];
}

+ (MOLExp *)integer:(NSInteger)left isGreaterThan:(NSInteger)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:left] operator:GT
                              right:[MOAExp fromInteger:right] parentheses:YES];
}

+ (MOLExp *)number:(NSNumber *)left isGreaterThan:(NSNumber *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:left] operator:GT
                              right:[MOAExp fromNumber:right] parentheses:YES];
}

+ (MOLExp *)string:(NSString *)left isGreaterThan:(NSString *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromString:left] operator:GT
                              right:[MOAExp fromString:right] parentheses:YES];
}

+ (MOLExp *)date:(NSDate *)left isGreaterThan:(NSDate *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromDate:left] operator:GT
                              right:[MOAExp fromDate:right] parentheses:YES];
}

+ (MOLExp *)data:(NSData *)left isGreaterThan:(NSData *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromData:left] operator:GT
                              right:[MOAExp fromData:right] parentheses:YES];
}

+ (MOLExp *)object:(id)left isGreaterThan:(id)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromObject:left] operator:GT
                              right:[MOAExp fromObject:right] parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left isGreaterThanOrEqualTo:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:GE right:right
                        parentheses:YES];
}

+ (MOLExp *)boolean:(BOOL)left isGreaterThanOrEqualTo:(BOOL)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromBool:left] operator:GE
                              right:[MOAExp fromBool:right] parentheses:YES];
}

+ (MOLExp *)integer:(NSInteger)left isGreaterThanOrEqualTo:(NSInteger)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:left] operator:GE
                              right:[MOAExp fromInteger:right] parentheses:YES];
}

+ (MOLExp *)number:(NSNumber *)left isGreaterThanOrEqualTo:(NSNumber *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:left] operator:GE
                              right:[MOAExp fromNumber:right] parentheses:YES];
}

+ (MOLExp *)string:(NSString *)left isGreaterThanOrEqualTo:(NSString *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromString:left] operator:GE
                              right:[MOAExp fromString:right] parentheses:YES];
}

+ (MOLExp *)date:(NSDate *)left isGreaterThanOrEqualTo:(NSDate *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromDate:left] operator:GE
                              right:[MOAExp fromDate:right] parentheses:YES];
}

+ (MOLExp *)data:(NSData *)left isGreaterThanOrEqualTo:(NSData *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromData:left] operator:GE
                              right:[MOAExp fromData:right] parentheses:YES];
}

+ (MOLExp *)object:(id)left isGreaterThanOrEqualTo:(id)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromObject:left] operator:GE
                              right:[MOAExp fromObject:right] parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left isLessThanOrEqualTo:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:LE right:right
                        parentheses:YES];
}

+ (MOLExp *)boolean:(BOOL)left isLessThanOrEqualTo:(BOOL)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromBool:left] operator:LE
                              right:[MOAExp fromBool:right] parentheses:YES];
}

+ (MOLExp *)integer:(NSInteger)left isLessThanOrEqualTo:(NSInteger)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:left] operator:LE
                              right:[MOAExp fromInteger:right] parentheses:YES];
}

+ (MOLExp *)number:(NSNumber *)left isLessThanOrEqualTo:(NSNumber *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:left] operator:LE
                              right:[MOAExp fromNumber:right] parentheses:YES];
}

+ (MOLExp *)string:(NSString *)left isLessThanOrEqualTo:(NSString *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromString:left] operator:LE
                              right:[MOAExp fromString:right] parentheses:YES];
}

+ (MOLExp *)date:(NSDate *)left isLessThanOrEqualTo:(NSDate *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromDate:left] operator:LE
                              right:[MOAExp fromDate:right] parentheses:YES];
}

+ (MOLExp *)data:(NSData *)left isLessThanOrEqualTo:(NSData *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromData:left] operator:LE
                              right:[MOAExp fromData:right] parentheses:YES];
}

+ (MOLExp *)object:(id)left isLessThanOrEqualTo:(id)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromObject:left] operator:LE
                              right:[MOAExp fromObject:right] parentheses:YES];
}

+ (MOLExp *)exp:(MOAExp *)left isLessThan:(MOAExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:LT right:right
                        parentheses:YES];
}

+ (MOLExp *)boolean:(BOOL)left isLessThan:(BOOL)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromBool:left] operator:LT
                              right:[MOAExp fromBool:right] parentheses:YES];
}

+ (MOLExp *)integer:(NSInteger)left isLessThan:(NSInteger)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:left] operator:LT
                              right:[MOAExp fromInteger:right] parentheses:YES];
}

+ (MOLExp *)number:(NSNumber *)left isLessThan:(NSNumber *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:left] operator:LT
                              right:[MOAExp fromNumber:right] parentheses:YES];
}

+ (MOLExp *)string:(NSString *)left isLessThan:(NSString *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromString:left] operator:LT
                              right:[MOAExp fromString:right] parentheses:YES];
}

+ (MOLExp *)date:(NSDate *)left isLessThan:(NSDate *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromDate:left] operator:LT
                              right:[MOAExp fromDate:right] parentheses:YES];
}

+ (MOLExp *)data:(NSData *)left isLessThan:(NSData *)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromData:left] operator:LT
                              right:[MOAExp fromData:right] parentheses:YES];
}

+ (MOLExp *)object:(id)left isLessThan:(id)right {
    return [MOLExpBoth lExpWithLeft:[MOAExp fromObject:left] operator:LT
                              right:[MOAExp fromObject:right] parentheses:YES];
}

+ (MOLExp *)exp:(MOLExp *)left and:(MOLExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:AND right:right
                        parentheses:YES];
}

+ (MOLExp *)exp:(MOLExp *)left or:(MOLExp *)right {
    return [MOLExpBoth lExpWithLeft:left operator:OR right:right
                        parentheses:YES];
}

+ (MOLExp *)notExp:(MOLExp *)exp {
    return [MOLExpRight lExpWithOperator:NOT forExpression:exp parentheses:YES];
}

+ (MOLExp *)isNullExp:(MOAExp *)exp {
    return [MOLExpLeft lExpWithExpression:exp operator:IS_NULL parentheses:YES];
}

+ (MOLExp *)isNotNullExp:(MOAExp *)exp {
    return [MOLExpLeft lExpWithExpression:exp operator:IS_NOT_NULL
                              parentheses:YES];
}

+ (MOLExp *)exists:(MOSelectQuery *)query {
    return [MOLExpRight lExpWithOperator:EXISTS
                           forExpression:[MOSubselect subselect:query] parentheses:NO];
}

+ (MOLExp *)andArray:(NSArray *)expressionArray {
    if ([expressionArray count] == 0) {
        return nil;
    }
    else if ([expressionArray count] == 1) {
        return [expressionArray objectAtIndex:0];
    }
    else {
        //recursion
        return [[expressionArray objectAtIndex:0]
                       and:[MOLExp andArray:
                            [expressionArray subarrayWithRange:
                             NSMakeRange(1, [expressionArray count]-1)]]];
    }
}

+ (MOLExp *)orArray:(NSArray *)expressionArray {
    if ([expressionArray count] == 0) {
        return nil;
    }
    else if ([expressionArray count] == 1) {
        return [expressionArray objectAtIndex:0];
    }
    else {
        //recursion
        return [[expressionArray objectAtIndex:0]
                        or:[MOLExp orArray:
                            [expressionArray subarrayWithRange:
                             NSMakeRange(1, [expressionArray count]-1)]]];
    }
}

- (MOLExp *)not {
    return [MOLExpRight lExpWithOperator:NOT
                           forExpression:self parentheses:NO];
}

- (MOLExp *)and:(MOLExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:AND right:exp parentheses:NO];
}

- (MOLExp *)or:(MOLExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:OR right:exp parentheses:NO];
}

- (NSString *)build {
    @throw [NSException exceptionWithName:@"Not implemented"
                                   reason:@"This class should be treated as an abstract one"
                                 userInfo:nil];
}

- (NSArray *)getParameters {
    @throw [NSException exceptionWithName:@"Not implemented"
                                   reason:@"This class should be treated as an abstract one"
                                 userInfo:nil];
}

@end
