//
//  MOInsertStatement.m
//  Mobi ORM
//

#import "MOInsertStatement.h"
#import "MOValue.h"

NSString *const INSERT = @"INSERT ";
NSString *const INTO = @"INTO ";
NSString *const VALUES = @" VALUES ";

@interface MOInsertStatement ()

@property MOTableExpression *table;
@property NSMutableArray *columns;
@property NSMutableArray *values;

- (void)isColumnFromRightTable:(MOColumn *)column;
- (void)checkIfTableProvided;
- (void)checkIfAnyColumnProvided;

@end

@implementation MOInsertStatement

+ (MOInsertStatement *)statementWithTableExpression:(MOTableExpression *)table {
    return [[MOInsertStatement alloc] initWithTableExpression:table];
}

- (id)initWithTableExpression:(MOTableExpression *)table {
    self = [super init];
    
    if (self) {
        self.table = table;
        self.columns = [[NSMutableArray alloc] init];
        self.values = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addColumn:(MOColumn *)column withValue:(id)value; {
    if (value) {
        [self isColumnFromRightTable:column];
        [self.columns addObject:column];
        [self.values addObject:[MOValue value:value withType:column.type]];
    }
}

- (NSString *)build {
    [self checkIfTableProvided];
    [self checkIfAnyColumnProvided];

    NSMutableString *columns = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    
    for (MOColumn *col in self.columns) {
        [columns appendString:[col buildWithoutTableDotPrefix]];
        [columns appendString:COMMA];
        
        [values appendString:QUESTION_MARK];
        [values appendString:COMMA];
    }
    
    //deleting redundant commas
    [columns deleteCharactersInRange:
                            NSMakeRange(columns.length - [COMMA length], 2)];
    [values deleteCharactersInRange:
                            NSMakeRange(values.length - [COMMA length], 2)];
    
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:INSERT];
    [result appendString:INTO];
    [result appendString:[self.table build]];
    [result appendString:SPACE];
    [result appendString:LP];
    [result appendString:columns];
    [result appendString:RP];
    [result appendString:VALUES];
    [result appendString:LP];
    [result appendString:values];
    [result appendString:RP];
    
    return result;
}

- (NSArray *)getParameters {
    [self checkIfTableProvided];
    [self checkIfAnyColumnProvided];
    return self.values;
}

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
