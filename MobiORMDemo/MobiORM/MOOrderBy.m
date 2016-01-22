//
//  MOOrderBy.m
//  Mobi ORM
//

#import "MOOrderBy.h"
#import "MOAExp.h"



NSString *const ASCENDING = @" ASC";
NSString *const DESCENDING = @" DESC";

@interface MOOrderBy ()

@property MOAExp *orderBy;
@property MOOrderByDirection dir;

- (NSString *)stringFromDirection:(MOOrderByDirection)dir;

@end

@implementation MOOrderBy

+ (MOOrderBy *)orderByColumn:(MOAExp *)orderBy withDirection:(MOOrderByDirection)direction {
    MOOrderBy *order= [[MOOrderBy alloc] init];
    
    order.orderBy = orderBy;
    order.dir = direction;
    
    return order;
}

+ (MOOrderBy *)orderAscByColumn:(MOAExp *)orderBy {
    return [MOOrderBy orderByColumn:orderBy withDirection:ASC];
}

+ (MOOrderBy *)orderDescByColumn:(MOAExp *)orderBy {
    return [MOOrderBy orderByColumn:orderBy withDirection:DESC];
}

- (NSString *)stringFromDirection:(MOOrderByDirection)dir {
    switch (dir) {
        case ASC:
            return ASCENDING;
        case DESC:
            return DESCENDING;
    }
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];

    [result appendString:[self.orderBy build]];
    [result appendString:[self stringFromDirection:self.dir]];
    
    return result;
}

- (NSArray *)getParameters {
    return [self.orderBy getParameters];
}

@end
