//
//  MOTableExpression.h
//  Mobi ORM
//
//  Represents table expression in SQL query.
//

#import <Foundation/Foundation.h>
#import "MODbType.h"
#import "MOExpression.h"
#import "MOColumn.h"

@class MOColumn;

@interface MOTableExpression : NSObject <MOExpression>

@property NSString *name;
@property NSMutableArray *columns;
@property NSMutableArray *blobColumns;
@property NSMutableArray *primaryKeyColumns;

+ (MOTableExpression *)tableWithName:(NSString *)name;
- (id)initWithName:(NSString *)name;

- (void)addColumn:(MOColumn *)column;
- (void)addColumnWithName:(NSString *)columnName type:(MODbType)type;

- (void)addBlobColumn:(MOColumn *)column;
- (void)addBlobColumnWithName:(NSString *)columnName;

// columns added as PK are automatically added to columns array too
- (void)addAsPrimaryKeyColumn:(MOColumn *)column;
- (void)addAsPrimaryKeyColumnWithName:(NSString *)columnName type:(MODbType)type;

- (MOColumn *)getColumnWithName:(NSString *)name;

@end
