//
//  MOSQLiteManager.h
//  Mobi ORM
//
//  Manages SQLite database and perform operations on it.
//

#import <Foundation/Foundation.h>
#import "MOExpression.h"
#import "MOSelectQuery.h"
#import "MOInsertStatement.h"
#import "MORowHandler.h"
#import "MOSQLiteDataSource.h"

@interface MOSQLiteManager : NSObject

+ (MOSQLiteManager *)managerWithDataSource:(id<MOSQLiteDataSource>)dataSource;

- (id)initWithDataSource:(id <MOSQLiteDataSource>)dataSource;

- (NSArray *)loadDataFromQuery:(MOSelectQuery *)query
                withRowHandler:(id <MORowHandler>)rowHandler;

- (void)executeQuery:(id<MOExpression>)query;

- (NSNumber *)executeInsertStatement:(MOInsertStatement *)insert;

@end
