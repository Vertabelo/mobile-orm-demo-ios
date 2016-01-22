//
//  MOAExp.m
//  Mobi ORM
//

#import "MOAExp.h"
#import "MOAExpFunction.h"
#import "MOAExpNegation.h"
#import "MOAExpOperator.h"
#import "MOAExpParentheses.h"
#import "MOAExpValue.h"
#import "MOLExpBoth.h"
#import "MOLExpLeft.h"
#import "MOLExpRight.h"
#import "MOLExpParentheses.h"
#import "MOValue.h"
#import "MOAExpList.h"
#import "MOSubselect.h"

NSInteger bigIntBorder = 2000000000;

@implementation MOAExp

+ (MOAExp *)fromBool:(BOOL)val {
    return [MOAExpValue aExpWithValue:[MOValue value:val?@YES:@NO
                                            withType:BOOLEAN]];
}

+ (MOAExp *)fromInteger:(NSInteger)val {
    return [MOAExpValue aExpWithValue:
            [MOValue value:[NSNumber numberWithInteger:val] withType:INT]];
}

+ (MOAExp *)withValue:(id)val type:(MODbType)type {
    return [MOAExpValue aExpWithValue:[MOValue value:val withType:type]];
}


+ (MOAExp *)fromNumber:(NSNumber *)val {
    double dValue = [val doubleValue];
    if (dValue == ceil(dValue) || dValue == floor(dValue)) {
        return [MOAExp withValue:val
                            type:(dValue > bigIntBorder ? BIGINT : INT)];
    } else {
        return [MOAExp withValue:val type:DOUBLE];
    }
}

+ (MOAExp *)fromString:(NSString *)val {
    return [MOAExp withValue:val type:[val length] > 256?TEXT:VARCHAR];
}

+ (MOAExp *)fromDate:(NSDate *)val {
    return [MOAExp withValue:val type:DATE];
}

+ (MOAExp *)fromData:(NSData *)val {
    return [MOAExp withValue:val type:BYTEA];
}

+ (MOAExp *)fromObject:(id)val {
    if ([val isKindOfClass:[MOAExp class]]) {
        return (MOAExp *)val;
    } else if ([val isKindOfClass:[NSString class]]) {
        return [MOAExp fromString:(NSString *)val];
    } else if ([val isKindOfClass:[NSNumber class]]) {
        return [MOAExp fromNumber:(NSNumber *)val];
    } else if ([val isKindOfClass:[NSData class]]) {
        return [MOAExp fromData:(NSData *)val];
    } else if ([val isKindOfClass:[NSDate class]]) {
        return [MOAExp fromDate:(NSDate *)val];
    } else {
        return nil;
    }
}

+ (MOAExp *)withLeftAExp:(MOAExp *)left operator:(MODbOperator)operator
                   rightAExp:(MOAExp *)right parentheses:(BOOL)parentheses {
    return [MOAExpOperator aExpWithLeft:left operator:operator right:right
                            parentheses:parentheses];
}

+ (MOAExp *)add:(MOAExp *)left to:(MOAExp *)right {
    return [MOAExp withLeftAExp:left operator:ADD rightAExp:right
                           parentheses:YES];
}

+ (MOAExp *)subFrom:(MOAExp *)left value:(MOAExp *)right {
    return [MOAExp withLeftAExp:left operator:SUB rightAExp:right
                           parentheses:YES];
}

+ (MOAExp *)mul:(MOAExp *)left by:(MOAExp *)right {
    return [MOAExp withLeftAExp:left operator:MUL rightAExp:right
                           parentheses:YES];
}

+ (MOAExp *)div:(MOAExp *)left by:(MOAExp *)right {
    return [MOAExp withLeftAExp:left operator:DIV rightAExp:right
                           parentheses:YES];
}

+ (MOAExp *)neg:(MOAExp *)exp {
    return [MOAExpNegation getNegatedExpressionFrom:exp];
}

+ (MOAExp *)funWithName:(NSString *)name forArgument:(MOAExp *)arg {
    if (arg) {
        return [MOAExpFunction aExpAsFunctionNamed:name forArguments:
                                        [NSMutableArray arrayWithObject:arg]];
    } else {
        return [MOAExpFunction aExpAsFunctionNamed:name forArguments:nil];
    }
}

+ (MOAExp *)funWithName:(NSString *)name forArguments:(NSArray *)args{
    return [MOAExpFunction aExpAsFunctionNamed:name forArguments:args];
}

- (MOAExp *)addAExp:(MOAExp *)exp {
    return [MOAExp withLeftAExp:self operator:ADD rightAExp:exp parentheses:NO];
}

- (MOAExp *)addNumber:(NSNumber *)num {
    return [MOAExp withLeftAExp:self operator:ADD
                      rightAExp:[MOAExp fromNumber:num] parentheses:NO];
}

- (MOAExp *)addString:(NSString *)num {
    return [MOAExp withLeftAExp:self operator:ADD
                      rightAExp:[MOAExp fromString:num] parentheses:NO];
}

- (MOAExp *)addData:(NSData *)num {
    return [MOAExp withLeftAExp:self operator:ADD
                      rightAExp:[MOAExp fromData:num] parentheses:NO];
}

- (MOAExp *)addDate:(NSDate *)num {
    return [MOAExp withLeftAExp:self operator:ADD
                      rightAExp:[MOAExp fromDate:num] parentheses:NO];
}

- (MOAExp *)addInteger:(NSInteger)num {
    return [MOAExp withLeftAExp:self operator:ADD
                                    rightAExp:[MOAExp fromInteger:num]
                                    parentheses:NO];
}

- (MOAExp *)add:(id)exp {
    if ([exp isKindOfClass:[MOAExp class]]) {
        return [self addAExp:(MOAExp *)exp];
    }
    else if ([exp isKindOfClass:[NSString class]]) {
        return [self addString:(NSString *)exp];
    }
    else if ([exp isKindOfClass:[NSNumber class]]) {
        return [self addNumber:(NSNumber *)exp];
    }
    else if ([exp isKindOfClass:[NSData class]]) {
        return [self addData:(NSData *)exp];
    }
    else if ([exp isKindOfClass:[NSDate class]]) {
        return [self addDate:(NSDate *)exp];
    }
    else {
        return nil;
    }
}

- (MOAExp *)subAExp:(MOAExp *)exp {
    return [MOAExp withLeftAExp:self operator:SUB rightAExp:exp parentheses:NO];
}

- (MOAExp *)subNumber:(NSNumber *)num {
    return [MOAExp withLeftAExp:self operator:SUB
                      rightAExp:[MOAExp fromNumber:num] parentheses:NO];
}

- (MOAExp *)subString:(NSString *)num {
    return [MOAExp withLeftAExp:self operator:SUB
                      rightAExp:[MOAExp fromString:num] parentheses:NO];
}

- (MOAExp *)subData:(NSData *)num {
    return [MOAExp withLeftAExp:self operator:SUB
                      rightAExp:[MOAExp fromData:num] parentheses:NO];
}

- (MOAExp *)subDate:(NSDate *)num {
    return [MOAExp withLeftAExp:self operator:SUB
                      rightAExp:[MOAExp fromDate:num] parentheses:NO];
}

- (MOAExp *)subInteger:(NSInteger)num {
    return [MOAExp withLeftAExp:self operator:SUB
                      rightAExp:[MOAExp fromInteger:num] parentheses:NO];
}

- (MOAExp *)sub:(id)exp {
    if ([exp isKindOfClass:[MOAExp class]]) {
        return [self subAExp:(MOAExp *)exp];
    }
    else if ([exp isKindOfClass:[NSString class]]) {
        return [self subString:(NSString *)exp];
    }
    else if ([exp isKindOfClass:[NSNumber class]]) {
        return [self subNumber:(NSNumber *)exp];
    }
    else if ([exp isKindOfClass:[NSData class]]) {
        return [self subData:(NSData *)exp];
    }
    else if ([exp isKindOfClass:[NSDate class]]) {
        return [self subDate:(NSDate *)exp];
    }
    else {
        return nil;
    }
}

- (MOAExp *)mulAExp:(MOAExp *)exp {
    return [MOAExp withLeftAExp:self operator:MUL rightAExp:exp parentheses:NO];
}

- (MOAExp *)mulNumber:(NSNumber *)num {
    return [MOAExp withLeftAExp:self operator:MUL
                      rightAExp:[MOAExp fromNumber:num] parentheses:NO];
}

- (MOAExp *)mulString:(NSString *)num {
    return [MOAExp withLeftAExp:self operator:MUL
                      rightAExp:[MOAExp fromString:num] parentheses:NO];
}

- (MOAExp *)mulData:(NSData *)num {
    return [MOAExp withLeftAExp:self operator:MUL
                      rightAExp:[MOAExp fromData:num] parentheses:NO];
}

- (MOAExp *)mulDate:(NSDate *)num {
    return [MOAExp withLeftAExp:self operator:MUL
                      rightAExp:[MOAExp fromDate:num] parentheses:NO];
}

- (MOAExp *)mulInteger:(NSInteger)num {
    return [MOAExp withLeftAExp:self operator:MUL
                      rightAExp:[MOAExp fromInteger:num] parentheses:NO];
}

- (MOAExp *)mul:(id)exp {
    if ([exp isKindOfClass:[MOAExp class]]) {
        return [self mulAExp:(MOAExp *)exp];
    }
    else if ([exp isKindOfClass:[NSString class]]) {
        return [self mulString:(NSString *)exp];
    }
    else if ([exp isKindOfClass:[NSNumber class]]) {
        return [self mulNumber:(NSNumber *)exp];
    }
    else if ([exp isKindOfClass:[NSData class]]) {
        return [self mulData:(NSData *)exp];
    }
    else if ([exp isKindOfClass:[NSDate class]]) {
        return [self mulDate:(NSDate *)exp];
    }
    else {
        return nil;
    }
}


- (MOAExp *)divAExp:(MOAExp *)exp {
    return [MOAExp withLeftAExp:self operator:DIV rightAExp:exp parentheses:NO];
}

- (MOAExp *)divNumber:(NSNumber *)num {
    return [MOAExp withLeftAExp:self operator:DIV
                      rightAExp:[MOAExp fromNumber:num] parentheses:NO];
}

- (MOAExp *)divString:(NSString *)num {
    return [MOAExp withLeftAExp:self operator:DIV
                      rightAExp:[MOAExp fromString:num] parentheses:NO];
}

- (MOAExp *)divData:(NSData *)num {
    return [MOAExp withLeftAExp:self operator:DIV
                      rightAExp:[MOAExp fromData:num] parentheses:NO];
}

- (MOAExp *)divDate:(NSDate *)num {
    return [MOAExp withLeftAExp:self operator:DIV
                      rightAExp:[MOAExp fromDate:num] parentheses:NO];
}

- (MOAExp *)divInteger:(NSInteger)num {
    return [MOAExp withLeftAExp:self operator:DIV
                      rightAExp:[MOAExp fromInteger:num] parentheses:NO];
}

- (MOAExp *)div:(id)exp {
    if ([exp isKindOfClass:[MOAExp class]]) {
        return [self divAExp:(MOAExp *)exp];
    }
    else if ([exp isKindOfClass:[NSString class]]) {
        return [self divString:(NSString *)exp];
    }
    else if ([exp isKindOfClass:[NSNumber class]]) {
        return [self divNumber:(NSNumber *)exp];
    }
    else if ([exp isKindOfClass:[NSData class]]) {
        return [self divData:(NSData *)exp];
    }
    else if ([exp isKindOfClass:[NSDate class]]) {
        return [self divDate:(NSDate *)exp];
    }
    else {
        return nil;
    }
}

- (MOAExp *)neg {
    return [MOAExp neg:self];
}

- (MOAExp *)asArgumentOfFunction:(NSString *)name {
    return [MOAExp funWithName:name forArgument:self];
}

- (MOAExp *)putInParentheses {
    return [MOAExpParentheses getInParenthesesExpression:self];
}

- (MOLExp *)isEqualTo:(id)object {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromObject:object] parentheses:NO];
}

- (MOLExp *)isEqualToExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:exp parentheses:NO];
}

- (MOLExp *)isEqualToBool:(BOOL)boolean {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromBool:boolean] parentheses:NO];
}

- (MOLExp *)isEqualToInteger:(NSInteger)integer {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromInteger:integer] parentheses:NO];
}

- (MOLExp *)isEqualToString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)isEqualToDate:(NSDate *)date {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromDate:date] parentheses:NO];
}

- (MOLExp *)isEqualToData:(NSData *)data {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromData:data] parentheses:NO];
}

- (MOLExp *)isEqualToNumber:(NSNumber *)number {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOAExp fromNumber:number] parentheses:NO];
}

- (MOLExp *)isEqualToQuery:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:EQ
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)isNotEqualTo:(id)object {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromObject:object] parentheses:NO];
}

- (MOLExp *)isNotEqualToExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:exp parentheses:NO];
}

- (MOLExp *)isNotEqualToBool:(BOOL)boolean {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromBool:boolean] parentheses:NO];
}

- (MOLExp *)isNotEqualToInteger:(NSInteger)integer {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromInteger:integer] parentheses:NO];
}

- (MOLExp *)isNotEqualToString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)isNotEqualToDate:(NSDate *)date {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromDate:date] parentheses:NO];
}

- (MOLExp *)isNotEqualToData:(NSData *)data {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromData:data] parentheses:NO];
}

- (MOLExp *)isNotEqualToNumber:(NSNumber *)number {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOAExp fromNumber:number] parentheses:NO];
}

- (MOLExp *)isNotEqualToQuery:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:NE
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)isGreaterThan:(id)object {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromObject:object] parentheses:NO];
}

- (MOLExp *)isGreaterThanExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:exp parentheses:NO];
}

- (MOLExp *)isGreaterThanBool:(BOOL)boolean {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromBool:boolean] parentheses:NO];
}

- (MOLExp *)isGreaterThanInteger:(NSInteger)integer {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromInteger:integer] parentheses:NO];
}

- (MOLExp *)isGreaterThanString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)isGreaterThanDate:(NSDate *)date {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromDate:date] parentheses:NO];
}

- (MOLExp *)isGreaterThanData:(NSData *)data {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromData:data] parentheses:NO];
}

- (MOLExp *)isGreaterThanNumber:(NSNumber *)number {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOAExp fromNumber:number] parentheses:NO];
}

- (MOLExp *)isGreaterThanQuery:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:GT
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualTo:(id)object {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromObject:object] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:exp parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToBool:(BOOL)boolean {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromBool:boolean] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToInteger:(NSInteger)integer {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromInteger:integer] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToDate:(NSDate *)date {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromDate:date] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToData:(NSData *)data {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromData:data] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToNumber:(NSNumber *)number {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOAExp fromNumber:number] parentheses:NO];
}

- (MOLExp *)isGreaterThanOrEqualToQuery:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:GE
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualTo:(id)object {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromObject:object] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:exp parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToBool:(BOOL)boolean {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromBool:boolean] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToInteger:(NSInteger)integer {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromInteger:integer] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToDate:(NSDate *)date {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromDate:date] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToData:(NSData *)data {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromData:data] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToNumber:(NSNumber *)number {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOAExp fromNumber:number] parentheses:NO];
}

- (MOLExp *)isLessThanOrEqualToQuery:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:LE
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)isLessThan:(id)object {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromObject:object] parentheses:NO];
}

- (MOLExp *)isLessThanExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:exp parentheses:NO];
}

- (MOLExp *)isLessThanBool:(BOOL)boolean {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromBool:boolean] parentheses:NO];
}

- (MOLExp *)isLessThanInteger:(NSInteger)integer {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromInteger:integer] parentheses:NO];
}

- (MOLExp *)isLessThanString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)isLessThanDate:(NSDate *)date {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromDate:date] parentheses:NO];
}

- (MOLExp *)isLessThanData:(NSData *)data {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromData:data] parentheses:NO];
}

- (MOLExp *)isLessThanNumber:(NSNumber *)number {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOAExp fromNumber:number] parentheses:NO];
}

- (MOLExp *)isLessThanQuery:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:LT
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)likeExp:(MOAExp *)exp {
    return [MOLExpBoth lExpWithLeft:self operator:LIKE right:exp parentheses:NO];
}

- (MOLExp *)likeString:(NSString *)string {
    return [MOLExpBoth lExpWithLeft:self operator:LIKE
                              right:[MOAExp fromString:string] parentheses:NO];
}

- (MOLExp *)between:(id)lower and:(id)upper {
    MOLExp *between = [MOLExpBoth lExpWithLeft:[MOAExp fromObject:lower]
                                    operator:AND right:[MOAExp fromObject:upper]
                                parentheses:NO];
    
    return [MOLExpBoth lExpWithLeft:self operator:BETWEEN right:between
                        parentheses:NO];
}

- (MOLExp *)betweenExp:(MOAExp *)lower and:(MOAExp *)upper {
     MOLExp *between = [MOLExpBoth lExpWithLeft:lower operator:AND
                                         right:upper parentheses:NO];

    return [MOLExpBoth lExpWithLeft:self operator:BETWEEN right:between
                        parentheses:NO];
}

- (MOLExp *)betweenInteger:(NSInteger)lower and:(NSInteger)upper {
    MOLExp *between = [MOLExpBoth lExpWithLeft:[MOAExp fromInteger:lower]
                                      operator:AND right:[MOAExp fromInteger:upper]
                                   parentheses:NO];
    
    return [MOLExpBoth lExpWithLeft:self operator:BETWEEN right:between
                        parentheses:NO];
}

- (MOLExp *)betweenNumber:(NSNumber *)lower and:(NSNumber *)upper {
    MOLExp *between = [MOLExpBoth lExpWithLeft:[MOAExp fromNumber:lower]
                                      operator:AND
                                         right:[MOAExp fromNumber:upper]
                                   parentheses:NO];
    
    return [MOLExpBoth lExpWithLeft:self operator:BETWEEN right:between
                        parentheses:NO];
}

- (MOLExp *)betweenString:(NSString *)lower and:(NSString *)upper {
    MOLExp *between = [MOLExpBoth lExpWithLeft:[MOAExp fromString:lower]
                                      operator:AND
                                         right:[MOAExp fromString:upper]
                                   parentheses:NO];
    
    return [MOLExpBoth lExpWithLeft:self operator:BETWEEN right:between
                        parentheses:NO];
}

- (MOLExp *)betweenDate:(NSDate *)lower and:(NSDate *)upper {
    MOLExp *between = [MOLExpBoth lExpWithLeft:[MOAExp fromDate:lower]
                                      operator:AND
                                         right:[MOAExp fromDate:upper]
                                   parentheses:NO];
    
    return [MOLExpBoth lExpWithLeft:self operator:BETWEEN right:between
                        parentheses:NO];
}

- (MOLExp *)isNull {
    return [MOLExpLeft lExpWithExpression:self operator:IS_NULL parentheses:NO];
}

- (MOLExp *)isNotNull {
    return [MOLExpLeft lExpWithExpression:self operator:IS_NOT_NULL parentheses:NO];
}


- (MOLExp *)in:(MOSelectQuery *)query {
    return [MOLExpBoth lExpWithLeft:self operator:IN
                              right:[MOSubselect subselect:query] parentheses:NO];
}

- (MOLExp *)inArray:(NSArray *)array {
    return [MOLExpBoth lExpWithLeft:self operator:IN
                              right:[MOAExpList getAExpListFromArray:array]
                        parentheses:NO];
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
