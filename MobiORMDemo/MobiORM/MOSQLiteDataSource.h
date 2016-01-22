//
//  MOSQLiteDataSource.h
//  Mobi ORM
//
//  Protocol to conform to for data source.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@protocol MOSQLiteDataSource <NSObject>

- (sqlite3 *)getConnection;

@end
