//
//  MOWhereStatement.m
//  Mobi ORM
//

#import "MOWhereStatement.h"
#import "MOValue.h"
#import "MOLExp.h"

NSString *const WHERE = @" WHERE ";

@implementation MOWhereStatement

- (id)initWithTableExpression:(MOTableExpression *)table {
    self = [super init];
    
    if (self) {
        self.table = table;
    }
    return self;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];

    if (self.where) {
        [result appendString:WHERE];
        [result appendString:[self.where build]];
    }
    
    return result;
}

- (NSArray *)getParameters {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    
    if (self.where) {
        [parameters addObjectsFromArray:[self.where getParameters]];
    }
    
    return parameters;
}

@end
