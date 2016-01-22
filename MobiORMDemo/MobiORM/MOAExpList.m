//
//  MOAExpList.m
//  Mobi ORM
//

#import "MOAExpList.h"

@interface MOAExpList ()

@property NSArray *expressions;

@end

@implementation MOAExpList

+ (MOAExp *)getAExpListFromArray:(NSArray *)array {
    MOAExpList *list = [[MOAExpList alloc] init];
    NSMutableArray *expressions = [[NSMutableArray alloc] init];
    
    for (id obj in array) {
        [expressions addObject:[MOAExp fromObject:obj]];
    }
    list.expressions = expressions;
    return list;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:LP];
    
    for (MOAExp *exp in self.expressions) {
        [result appendString:[exp build]];
        [result appendString:COMMA];
    }
    
    if ([self.expressions count] > 0) {
        //deleting redundant comma
        [result deleteCharactersInRange:
                            NSMakeRange([result length] - [COMMA length], 2)];
    }
    
    [result appendString:RP];
    return result;
}

- (NSArray *)getParameters {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (MOAExp *exp in self.expressions) {
        [result addObjectsFromArray:[exp getParameters]];
    }
    return result;
}

@end
