//
//  MOUpdateStatement.m
//  Mobi ORM
//

#import "MOUpdateStatement.h"
#import "MOValue.h"

NSString *const UPDATE = @"UPDATE ";
NSString *const SET = @" SET ";
NSString *const EQ_QUESTION_MARK = @" = ?";

@interface MOUpdateStatement ()

@property NSMutableArray *columns;
@property NSMutableArray *values;

- (void)isColumnFromRightTable:(MOColumn *)column;
- (void)checkIfTableProvided;
- (void)checkIfAnyColumnProvided;

@end

@implementation MOUpdateStatement

+ (MOUpdateStatement *)statementWithTableExpression:(MOTableExpression *)table {
    return [[MOUpdateStatement alloc] initWithTableExpression:table];
}

- (id)initWithTableExpression:(MOTableExpression *)table {
    self = [super initWithTableExpression:table];
    
    if (self) {
        self.columns = [[NSMutableArray alloc] init];
        self.values = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)updateColumn:(MOColumn *)column withValue:(id)value {
    if (value) {
        [self isColumnFromRightTable:column];
        [self.columns addObject:column];
        [self.values addObject:[MOValue value:value withType:column.type]];
    }
}

- (NSString *)build {
    [self checkIfTableProvided];
    [self checkIfAnyColumnProvided];

    NSMutableString *toSet = [[NSMutableString alloc] init];
    
    for (MOColumn *col in self.columns) {
        [toSet appendString:[col buildWithoutTableDotPrefix]];
        [toSet appendString:EQ_QUESTION_MARK];
        [toSet appendString:COMMA];
    }
    
    // redundant commas
    [toSet deleteCharactersInRange:
                                NSMakeRange(toSet.length - [COMMA length], 2)];
         
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:UPDATE];
    [result appendString:[self.table build]];
    [result appendString:SET];
    [result appendString:toSet];
    
    // adds WHERE clause
    [result appendString:[super build]];
    
    return result;
}

- (NSArray *)getParameters {
    [self checkIfTableProvided];
    [self checkIfAnyColumnProvided];

    NSMutableArray *parameters = [NSMutableArray arrayWithArray:self.values];
    
    // adds values from WHERE clause
    [parameters addObjectsFromArray:[super getParameters]];
    
    return parameters;
}

// column has to belong to the table from init
- (void)isColumnFromRightTable:(MOColumn *)column {
    if (![column.owner.name isEqualToString:self.table.name]) {
        @throw [NSException exceptionWithName:@"Illegal column used"
                                       reason:@"Column has to belong to statement's table."
                                     userInfo:nil];
    }
}

- (void)checkIfTableProvided {
    if (!self.table) {
        @throw [NSException exceptionWithName:@"You have to provide table expression"
                                       reason:@"Can not build query without table provided"
                                     userInfo:nil];
    }
}

- (void)checkIfAnyColumnProvided {
    if (!self.columns || [self.columns count] == 0) {
        @throw [NSException exceptionWithName:@"You have to provide at least one column"
                                       reason:@"Can not build query without any column provided"
                                     userInfo:nil];
    }
}

@end
