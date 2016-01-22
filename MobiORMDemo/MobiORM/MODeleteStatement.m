//
//  MODeleteStatement.m
//  Mobi ORM
//

#import "MODeleteStatement.h"

NSString *const DELETE_FROM = @"DELETE FROM ";

@interface MODeleteStatement ()

- (void)checkIfTableProvided;

@end

@implementation MODeleteStatement

+ (MODeleteStatement *)statementWithTableExpression:(MOTableExpression *)table {
    return [[MODeleteStatement alloc] initWithTableExpression:table];
}

- (NSString *)build {
	[self checkIfTableProvided];

    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:DELETE_FROM];
    [result appendString:[self.table build]];
    
    //adds WHERE
    [result appendString:[super build]];
    
    return result;
}

- (NSArray *)getParameters {
    //returns parameters for WHERE clause
    return [super getParameters];
}

- (void)checkIfTableProvided {
    if (!self.table) {
        @throw [NSException exceptionWithName:@"You have to provide table expression"
                                       reason:@"Can not build query without table provided"
                                     userInfo:nil];
    }
}

@end
