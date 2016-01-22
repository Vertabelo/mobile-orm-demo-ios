//
//  MOSQLiteOpenHelper.h
//  mobi-orm
// 
//  This is the implementation of MOSQLiteDataSource protocol provided by us. 
//
//  You have to create your own class and inherit from MOSQLiteOpenHelper. Then, override
//  configure method with your database version, create and migration scripts.
//  You HAVE TO provide current database version using self.dbVersion = ?
//  or [self setDbVersion:?]  in configure method - if not, exception will be thrown.
//  To add migration and create scripts, you have to invoke addCreateScript:
//  and addMigrationScript:from: methods in your subclass with the full names
//  of your scripts (also containing extension, for example my_script.sql).
//  It's all you have to do - creating database and running migrations will be done
//  by MOSQLiteOpenHelper automatically.
// 
//  MOSQLiteOpenHelper is also able to perform transactions with database using
//  doWithTransaction: method.
// 

#import <Foundation/Foundation.h>
#import "MOSQLiteDataSource.h"

@interface MOSQLiteOpenHelper : NSObject <MOSQLiteDataSource>

// property and functions to implement configure method in subclass
@property NSInteger dbVersion; 
- (void)addCreateScript:(NSString *)scriptName;
- (void)addMigrationScript:(NSString *)scriptName from:(NSInteger)fromVersion;

// functions to use 
- (id)initWithDbName:(NSString *)dbName;
- (void)doWithTransaction:(BOOL (^)(void))operationsBlock;
- (void)closeDb;

@end
