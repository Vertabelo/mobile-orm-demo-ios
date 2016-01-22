//
//  MOSQLiteManager.m
//  Mobi ORM
//

#import "MOSQLiteManager.h"
#import "MOValue.h"
#import "MODate.h"

@interface MOSQLiteManager ()

@property sqlite3 *db;

- (NSArray *)getQueryResult:(sqlite3_stmt *)statement;
- (void)bindParameters:(NSArray *)params
          forStatement:(sqlite3_stmt *)statement;

@end

@implementation MOSQLiteManager

+ (id)managerWithDataSource:(id<MOSQLiteDataSource>)dataSource {
    return [[MOSQLiteManager alloc] initWithDataSource:dataSource];
}

- (id)initWithDataSource:(id<MOSQLiteDataSource>)dataSource {
    self = [super init];
    
    if (self) {
        _db = [dataSource getConnection];
    }
    return self;
}

- (NSArray *)loadDataFromQuery:(MOSelectQuery *)query
                withRowHandler:(id<MORowHandler>)rowHandler {
    
    sqlite3_stmt *statement = [self prepareStatementForQuery:[query build]
                                              withParameters:[query getParameters]];
    if (!statement) {
        return nil;
    }
    
    NSArray *result = [self getQueryResult:statement];
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (NSArray *row in result) {
        [objects addObject:[rowHandler getObjectFromRow:row]];
    }
    
    sqlite3_finalize(statement);
    return objects;
}

- (int)runQuery:(id<MOExpression>)query {
    sqlite3_stmt *statement = [self prepareStatementForQuery:[query build]
                                              withParameters:[query getParameters]];
    if (!statement) {
        return SQLITE_ERROR;
    }
    
    int result = sqlite3_step(statement);
    sqlite3_finalize(statement);
    return result;
}

- (void)executeQuery:(id<MOExpression>)query {
    int result = [self runQuery:query];
    
    if (result != SQLITE_DONE) {
        // error in executing query
        NSLog(@"%s", sqlite3_errmsg(self.db));
    }
}

- (NSNumber *)executeInsertStatement:(MOInsertStatement *)insert {
    int result = [self runQuery:insert];

    if (result == SQLITE_DONE) {
        return [NSNumber numberWithLongLong:sqlite3_last_insert_rowid(self.db)];
    } else {
        NSLog(@"%s", sqlite3_errmsg(self.db));
        return nil;
    }
}

- (sqlite3_stmt *)prepareStatementForQuery:(NSString *)query
                            withParameters:(NSArray *)params {
    sqlite3_stmt *statement;
    
    // downloads data from database
    if(sqlite3_prepare_v2(self.db, [query UTF8String], -1, &statement, NULL)
       != SQLITE_OK) {
        
        // error during downloading occurred
        NSLog(@"%s", sqlite3_errmsg(self.db));
        sqlite3_close(self.db);
        return NULL;
    }
    
    // binding
    if (params) {
        [self bindParameters:(NSArray *)params
                forStatement:(sqlite3_stmt *)statement];
    }
    
    return statement;
}

// returns array of arrays with results returned by non-executable query
- (NSArray *)getQueryResult:(sqlite3_stmt *)statement {
    
    // array for arrays containg every row's result
    NSMutableArray *resultRows = [[NSMutableArray alloc] init];
    
    // iterating through results and adding every row
    while(sqlite3_step(statement) == SQLITE_ROW) {

        //array to store data from a row
        NSMutableArray *rowData = [[NSMutableArray alloc] init];
        int totalColumns = sqlite3_column_count(statement);
        
        for (int i=0; i<totalColumns; i++){
            switch(sqlite3_column_type(statement, i)) {
                    
                case SQLITE_INTEGER: {
                    long long result = sqlite3_column_int64(statement, i);
                    [rowData addObject:[NSNumber numberWithLongLong:result]];
                    break;
                }
                    
                case SQLITE_FLOAT: {
                    double result = sqlite3_column_double(statement, i);
                    [rowData addObject:[NSNumber numberWithDouble:result]];
                    break;
                }
                    
                case SQLITE_TEXT: {
                    char *result = (char *)sqlite3_column_text(statement, i);
                    [rowData addObject:[NSString stringWithUTF8String:result]];
                    break;
                }
                
                case SQLITE_BLOB: {
                    const void *result = sqlite3_column_blob(statement, i);
                    int resultLen = sqlite3_column_bytes(statement, i);
                    [rowData addObject:[NSData dataWithBytes:result length:resultLen]];
                }
                    
                case SQLITE_NULL: {
                    [rowData addObject:[NSNull null]];
                }
            }
        }
        
        // saves data from columns, if there was any data
        if (rowData.count > 0) {
            [resultRows addObject:rowData];
        }
    }
    return resultRows;
}

// binds in compiled statement question marks with values
- (void)bindParameters:(NSArray *)params
          forStatement:(sqlite3_stmt *)statement {
    int index = 1;
    for (MOValue *param in params) {
        switch (param.type) {
            case INT:
            case SMALLINT:
            case BOOLEAN: {
                if (sqlite3_bind_int(statement, index++, [param.value intValue])
                                     != SQLITE_OK) {
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }
                
            case BIGINT: {
                if (sqlite3_bind_int64(statement, index++,
                    (sqlite3_int64)[param.value longLongValue]) != SQLITE_OK) {
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }
                
            case DECIMAL:
            case FLOAT:
            case DOUBLE: {
                if (sqlite3_bind_double(statement, index++,
                                        [param.value doubleValue]) != SQLITE_OK) {
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }
                
            case VARCHAR:
            case CHAR:
            case TIME:
            case TEXT: {
                if (sqlite3_bind_text(statement, index++, [param.value UTF8String],
                                      -1, SQLITE_TRANSIENT) != SQLITE_OK) {
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }

            case DATE: {
                MODate *moDate = param.value;
                [moDate checkDateCorrectness];
                const char *str = [[moDate toNSString] UTF8String];
                if (sqlite3_bind_text(statement, index++, str, -1,
                                    SQLITE_TRANSIENT) != SQLITE_OK) {
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }

            case TIMESTAMP: {
                if (sqlite3_bind_double(statement, index++,
                                        [param.value timeIntervalSince1970]) != SQLITE_OK) {
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }
                
            case BYTEA: {
                if (sqlite3_bind_blob(statement, index++, [param.value bytes],
                    (int)[param.value length] , SQLITE_STATIC) != SQLITE_OK){
                    NSLog(@"%s", sqlite3_errmsg(self.db));
                }
                break;
            }
        }
    }
}

@end
