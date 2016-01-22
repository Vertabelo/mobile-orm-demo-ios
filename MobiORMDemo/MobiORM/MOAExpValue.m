//
//  MOAExpValue.m
//  Mobi ORM
//

#import "MOAExpValue.h"
#import "MOValue.h"

@interface MOAExpValue ()

@property MOValue *value;

@end

@implementation MOAExpValue

+ (MOAExp *)aExpWithValue:(MOValue *)value {
    MOAExpValue *result = [[MOAExpValue alloc] init];
    result.value = value;
    return result;
}

- (NSString *)build {
    return [NSMutableString stringWithString:QUESTION_MARK];;
}

- (NSMutableArray *)getParameters {
    return [NSMutableArray arrayWithObject:self.value];
}

@end
