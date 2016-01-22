//
//  MOSubselect.m
//  Mobi ORM
//

#import "MOSubselect.h"

@implementation MOSubselect

+ (MOSubselect *)subselect:(MOSelectQuery *)query {
    return [[MOSubselect alloc] initWithSelect:query];
}

- (id)initWithSelect:(MOSelectQuery *)query {
    self = [super init];
    
    if (self) {
        self.query = query;
    }
    return self;
}

// returns correct SQL query in parentheses with question marks in place of values
- (NSString *)build {
    return [NSString stringWithFormat:@"(%@)", [self.query build]];
}

- (NSArray *)getParameters {
    return [self.query getParameters];
}

@end
