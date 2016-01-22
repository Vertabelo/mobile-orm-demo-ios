//
//  MOSelectQuery.m
//  Mobi ORM
//
//  Class should know itself as less as possible about its elements to not create
//  unncessary dependencies, so that's why I'm invoking build and getParameters
//  methods even when I know that they would return empty string/table.
//

#import "MOSelectQuery.h"
#import "MOValue.h"
#import "MOOrderBy.h"
#import "MOLExp.h"

NSString *const SELECT = @"SELECT ";
NSString *const DISTINCT = @"DISTINCT ";
NSString *const FROM = @" FROM ";
NSString *const GROUP_BY = @" GROUP BY ";
NSString *const ORDER_BY = @" ORDER BY ";
NSString *const HAVING = @" HAVING ";
NSString *const AS = @" AS ";
NSString *const LIMIT = @" LIMIT ";
NSString *const OFFSET = @" OFFSET ";

@interface MOSelectQuery ()

- (NSString *)buildSelect;
- (NSString *)buildFrom;
- (NSString *)buildGroupBy;
- (NSString *)buildOrderBy;
- (NSString *)buildHaving;
- (NSString *)buildLimit;

- (NSArray *)getParametersForWhere;
- (NSArray *)getParametersForGroupBy;
- (NSArray *)getParametersForOrderBy;
- (NSArray *)getParametersForHaving;
- (NSArray *)getParametersForLimit;

- (void)checkIfTableProvided;
- (void)checkIfLimitCorrect;
- (void)checkIfOffsetCorrect;

@end

@implementation MOSelectQuery

+ (MOSelectQuery *)selectFromTable:(MOTableExpression *)table {
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.tableExpressions = [NSArray arrayWithObject:table];
    query.columns = table.columns;
    return query;
}

+ (MOSelectQuery *)selectColumns:(NSArray *)columns fromTable:(MOTableExpression *)table {
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.columns = columns;
    query.tableExpressions = [NSArray arrayWithObject:table];
    return query;
}

+ (MOSelectQuery *)selectColumn:(id<MOExpression>)column fromTable:(MOTableExpression *)table {
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.columns = [NSArray arrayWithObject:column];
    query.tableExpressions = [NSArray arrayWithObject:table];
    return query;
}

+ (MOSelectQuery *)selectFromTables:(NSArray *)tables {
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.tableExpressions = tables;
    
    NSMutableArray *tempColumns = [NSMutableArray array];
    for (MOTableExpression *table in query.tableExpressions) {
        for (MOColumn *col in table.columns) {
            [tempColumns addObject:col];
        }
    }
    query.columns = tempColumns;
    return query;
}

+ (MOSelectQuery *)selectColumns:(NSArray *)columns fromTables:(NSArray *)tables {
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.columns = columns;
    query.tableExpressions = tables;
    return query;
}

+ (MOSelectQuery *)selectColumn:(id<MOExpression>)column fromTables:(NSArray *)tables {
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.columns = [NSArray arrayWithObject:column];
    query.tableExpressions = tables;
    return query;
}

+ (MOSelectQuery *)selectColumns:(NSArray *)columns fromTables:(NSArray *)tables
         where:(MOLExp *)where groupBy:(NSArray *)groupyBy
        orderBy:(NSArray *)orderBy having:(MOLExp *)having
      withLimit:(NSNumber *)limit withOffset:(NSNumber *)offset
     isDistinct:(BOOL)distinct {
    
    MOSelectQuery *query = [[MOSelectQuery alloc] init];
    query.columns = columns;
    query.tableExpressions = tables;
    query.where = where;
    query.groupBy = groupyBy;
    query.orderBy = orderBy;
    query.having = having;
    query.limit = limit;
    query.offset = offset;
    query.isDistinct = distinct;
    return query;
}

- (NSString *)build {
    [self checkIfTableProvided];

    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:[self buildSelect]];
    [result appendString:[self buildFrom]];
    [result appendString:[self buildWhere]];
    [result appendString:[self buildGroupBy]];
    [result appendString:[self buildHaving]];
    [result appendString:[self buildOrderBy]];
    [result appendString:[self buildLimit]];
    
    return result;
}

- (NSArray *)getParameters {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [result addObjectsFromArray:[self getParametersForSelect]];
    [result addObjectsFromArray:[self getParametersForFrom]];
    [result addObjectsFromArray:[self getParametersForWhere]];
    [result addObjectsFromArray:[self getParametersForGroupBy]];
    [result addObjectsFromArray:[self getParametersForHaving]];
    [result addObjectsFromArray:[self getParametersForOrderBy]];
    [result addObjectsFromArray:[self getParametersForLimit]];
    
    return result;
}

- (NSString *)buildSelect {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:SELECT];
    
    if (self.isDistinct) {
        [result appendString:DISTINCT];
    }
    
    for (id<MOExpression> col in self.columns) {
        [result appendString:[col build]];
        [result appendString:COMMA];
    }
    
    //deleting redundant comma
    [result deleteCharactersInRange:
                            NSMakeRange([result length] - [COMMA length], 2)];
    
    return result;
}

- (NSArray *)getParametersForSelect {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (id<MOExpression> exp in self.columns) {
        [arr addObjectsFromArray:[exp getParameters]];
    }
    
    return arr;
}

- (NSString *)buildFrom {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:FROM];
    
    for (MOTableExpression *table in self.tableExpressions) {
        [result appendString:[table build]];
        [result appendString:COMMA];
    }
    
    // not checks if null, since queries without tables are not supported
    [result deleteCharactersInRange:
                            NSMakeRange([result length] - [COMMA length], 2)];
    
    return result;
}

- (NSArray *)getParametersForFrom {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (MOTableExpression *table in self.tableExpressions) {
        [arr addObjectsFromArray:[table getParameters]];
    }
    
    return arr;
}

- (NSString *)buildWhere {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (self.where) {
        [result appendString:WHERE];
        [result appendString:[self.where build]];
    }
    
    return result;
}

- (NSArray *)getParametersForWhere {
    return [self.where getParameters];
}

- (NSString *)buildGroupBy {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (self.groupBy && [self.groupBy count] > 0) {
        [result appendString:GROUP_BY];
        
        for (MOAExp *exp in self.groupBy) {
            [result appendString:[exp build]];
            [result appendString:COMMA];
        }
        
        // redundant comma
        [result deleteCharactersInRange:
                            NSMakeRange([result length] - [COMMA length], 2)];
    }
    
    return result;
}

- (NSArray *)getParametersForGroupBy {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (MOAExp *exp in self.groupBy) {
        [arr addObjectsFromArray:[exp getParameters]];
    }
    
    return arr;
}

- (NSString *)buildOrderBy {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (self.orderBy && [self.orderBy count] > 0) {
        [result appendString:ORDER_BY];
        
        for (MOOrderBy *exp in self.orderBy) {
            [result appendString:[exp build]];
            [result appendString:COMMA];
        }
        
        // redundant comma
        [result deleteCharactersInRange:
                            NSMakeRange([result length] - [COMMA length], 2)];
    }
    
    return result;
}

- (NSArray *)getParametersForOrderBy {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (MOAExp *exp in self.orderBy) {
        [arr addObjectsFromArray:[exp getParameters]];
    }
    
    return arr;
}

- (NSString *)buildHaving {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (self.having) {
        [result appendString:HAVING];
        [result appendString:[self.having build]];
    }
    
    return result;
}

- (NSArray *)getParametersForHaving {
    return self.having ? [self.having getParameters] : [NSArray array];
}

- (NSString *)buildLimit {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (self.limit) {
        [self checkIfLimitCorrect];
        [result appendString:LIMIT];
        [result appendString:QUESTION_MARK];
    }
    
    if (self.offset) {
        [self checkIfOffsetCorrect];
        [result appendString:OFFSET];
        [result appendString:QUESTION_MARK];
    }
    
    return result;
}

- (NSArray *)getParametersForLimit {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    if (self.limit) {
        [self checkIfLimitCorrect];
        [arr addObject:[MOValue value:self.limit withType:INT]];
    }
    
    if (self.offset) {
        [self checkIfOffsetCorrect];
        [arr addObject:[MOValue value:self.limit withType:INT]];
    }
    
    return arr;
}

- (id)init {
    self = [super init];

    if (self) {
        self.columns = [NSMutableArray array];
        self.tableExpressions = [NSMutableArray array];
        self.groupBy = [NSMutableArray array];
        self.orderBy = [NSMutableArray array];
    }
    return self;
}

- (void)checkIfTableProvided {
    if (!self.tableExpressions || [self.tableExpressions count] == 0) {
        @throw [NSException exceptionWithName:@"You have to provide table expression"
                                       reason:@"Can not build query without table provided"
                                     userInfo:nil];
    }
}

- (void)checkIfLimitCorrect {
    double dValue = [self.limit doubleValue];
    if (dValue < 0) {
        @throw [NSException exceptionWithName:@"Negative limit"
                                       reason:@"Limit for SELECT query can't be negative"
                                     userInfo:nil];
    } else {
        if (dValue != ceil(dValue)) {
            @throw [NSException exceptionWithName:@"Floating point limit"
                                       reason:@"Limit for SELECT query can't be floating point number"
                                     userInfo:nil];
        }
    }
}

- (void)checkIfOffsetCorrect {
    double dValue = [self.offset doubleValue];
    if (dValue < 0) {
        @throw [NSException exceptionWithName:@"Negative offset"
                                       reason:@"Offset for SELECT query can't be negative"
                                     userInfo:nil];
    } else {
        if (dValue != ceil(dValue)) {
            @throw [NSException exceptionWithName:@"Floating point offset"
                                       reason:@"Offset for SELECT query can't be floating point number"
                                     userInfo:nil];
        }
    }
}

@end
