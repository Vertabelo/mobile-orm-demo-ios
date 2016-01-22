//
//  MOSelectQuery.h
//  Mobi ORM
//
//  Represents an SQL SELECT query.
//

#import "MOWhereStatement.h"
#import "MOTableExpression.h"
#import "MOOrderBy.h"

@interface MOSelectQuery : MOWhereStatement

@property BOOL isDistinct;
@property NSArray *columns;
@property NSArray *tableExpressions;
@property NSArray *groupBy;
@property NSArray *orderBy;
@property MOLExp *having;
@property NSNumber *limit;
@property NSNumber *offset;

+ (MOSelectQuery *)selectFromTable:(MOTableExpression *)table;

+ (MOSelectQuery *)selectColumns:(NSArray *)columns fromTable:(MOTableExpression *)table;

+ (MOSelectQuery *)selectColumn:(id<MOExpression>)column fromTable:(MOTableExpression *)table;

+ (MOSelectQuery *)selectFromTables:(NSArray *)tables;

+ (MOSelectQuery *)selectColumns:(NSArray *)columns fromTables:(NSArray *)tables;

+ (MOSelectQuery *)selectColumn:(id<MOExpression>)column fromTables:(NSArray *)tables;

+ (MOSelectQuery *)selectColumns:(NSArray *)columns fromTables:(NSArray *)tables
         where:(MOLExp *)where groupBy:(NSArray *)groupyBy
       orderBy:(NSArray *)orderBy having:(MOLExp *)having
     withLimit:(NSNumber *)limit withOffset:(NSNumber *)offset
    isDistinct:(BOOL)distinct;

@end
