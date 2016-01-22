//
//  MOSQLiteOpenHelper.m
//  mobi-orm
//
//  Check MOSQLiteOpenHelper.h for instructions how to deal with that class.
//


#import "MOSQLiteOpenHelper.h"

NSString *CURRENT_DB_VERSION_KEY = @"MobiORM_currentDbVersion";

@interface MOSQLiteOpenHelper ()

@property NSString *dbName;
@property sqlite3 *sqliteConnection;
@property NSMutableDictionary *migrationScripts;
@property NSMutableArray *createScripts;

- (void)configure;
- (void)openOrCreateDb;
- (NSString *)getDbPath;
- (BOOL)doesExistsDatabaseAtPath:(NSString *)dbPath;
- (BOOL)installDb;
- (NSInteger)getCurrentDbVersionNumber;
- (void)setCurrentDbVersionNumber:(NSInteger)versionNumber;
- (void)runMigrationScriptsIfNeeded;
- (BOOL)runMigrationScriptsFrom:(NSInteger)fromVersion to:(NSInteger)toVersion;
- (BOOL)execContentOfFile:(NSString *)name;
- (BOOL)execSqlFromUTF8String:(const char *)content;
- (BOOL)fileExists:(NSString *)fileName;
- (void)checkIfDatabaseVersionProvided;
- (BOOL)isInTransaction;

@end

@implementation MOSQLiteOpenHelper 

- (void)configure {
    // 
    // This is configure method you have to override in your subclass
    //
    // You HAVE TO provide current database version using
    // self.dbVersion = 5; (or [self setDbVersion:5])
    // 
    // You HAVE TO provide SQL script to create a database using
    // addCreateScript:, for example:
    // [self addCreateScript:@"init.sql"];
    // Remember to provide file's full name, including extension.
    // You can also provide some additional create scripts,
    // like initial data - use addCreateScript: in the same way.
    // 
    // You can add migration scripts using addMigrationScript:from:, for example:
    // [self addMigrationScript:@"from_1.sql" from:1]
    //
    // Migration scripts are supposed to upgrade database's version by one,
    // for example from 6 to 7. Migration, for example, from 3 to 7 is done
    // by running all migration scripts between these versions.
    // 
    // You can provide multiple migration scripts even for one version migration.
    //
}

- (id)initWithDbName:(NSString *)dbName {
    self = [super init];

    if (self) {
        self.dbName = dbName;
        self.migrationScripts = [[NSMutableDictionary alloc] init];
        self.createScripts = [[NSMutableArray alloc] init];
        self.dbVersion = -1;
    }
    return self;
}

- (void)doWithTransaction:(BOOL (^)(void))operationsBlock {
    [self execSqlFromUTF8String:"BEGIN"];

    BOOL commitTransaction;
    @try {
        commitTransaction = operationsBlock();
    }
    @catch (NSException *exception) {
        [self execSqlFromUTF8String:"ROLLBACK"];
        @throw exception;
    }
    
    if(commitTransaction){
        [self execSqlFromUTF8String:"COMMIT"];
        
    } else {
        [self execSqlFromUTF8String:"ROLLBACK"];
    }
}

- (void)closeDb {
    if(self.sqliteConnection != NULL){
        sqlite3_close(self.sqliteConnection);
    }
    self.sqliteConnection = NULL;
}

- (sqlite3 *)getConnection {
    if (self.sqliteConnection == NULL) {
        [self openOrCreateDb];
    }
    return self.sqliteConnection;
}

- (void)addCreateScript:(NSString *)scriptName {
    [self.createScripts addObject:scriptName];
}

- (void)addMigrationScript:(NSString *)scriptName from:(NSInteger)fromVersion {
    NSMutableArray *scriptsArray = [self.migrationScripts objectForKey:@(fromVersion)];
    if (scriptsArray) {
        [scriptsArray addObject:scriptName];
    } else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:scriptName];
        [self.migrationScripts setObject:arr forKey:@(fromVersion)];
    }
}

- (void)openOrCreateDb {
    NSString *dbPath = [self getDbPath];
    BOOL databaseExisted = [self doesExistsDatabaseAtPath:dbPath];
    
    if(sqlite3_open_v2([dbPath UTF8String], &_sqliteConnection,
        SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX,
        NULL) != SQLITE_OK){

        sqlite3_close(self.sqliteConnection);
        NSAssert(0, @"Unable to connect to database");
    }
    
    if(sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_ERROR){
        NSLog(@"SQLITE_CONFIG_SERIALIZED not set - error returned");
    }
    
    if(!databaseExisted) {
        [self configure];
        [self checkIfDatabaseVersionProvided];

        // database didn't exist - we should create it now
        if ([self installDb]) {
            // changing database version only if installation succeeded
            [self setCurrentDbVersionNumber:self.dbVersion];  
        } else {
            if ([self isInTransaction]) {
                [self execSqlFromUTF8String:"ROLLBACK"];
            }
            [self closeDb];
            NSException *ex = [NSException
                    exceptionWithName:@"DatabaseInstallationFailedException"
                    reason:@"Given create scripts don't exist or are incorrect"
                    userInfo:nil];
            @throw ex;
        }
    } else {
        [self runMigrationScriptsIfNeeded];
    }
}

- (NSString *)getDbPath {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *docDir = [dirPaths objectAtIndex:0];
    
    // if there's not an Application Support directory - create it
    if (![[NSFileManager defaultManager] fileExistsAtPath:docDir isDirectory:NULL]) {
        NSError *error = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"%@", error.localizedDescription);
            NSException *ex = [NSException
                    exceptionWithName:@"CreatingApplicationSupportDirectoryError"
                    reason:@"Application Support directory did not exist and we could not create it."
                    userInfo:nil];
            @throw ex;
        }
     }
     
    NSString *dbPath = [[NSString alloc] initWithString:[docDir stringByAppendingPathComponent:self.dbName]];
    return dbPath;
}

- (BOOL)doesExistsDatabaseAtPath:(NSString *)dbPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:dbPath];
}


- (BOOL)installDb {
    for (NSString *scriptName in self.createScripts) {
        if([self fileExists:scriptName]){
            NSLog(@"running create script: %@", scriptName);
            if(![self execContentOfFile:scriptName]) {
                return NO;
            }
        } else {
            NSLog(@"WARNING, create script %@ does not exist! Skipping it.", scriptName);
            return NO;
        }
    }
    return YES;
}

- (void)runMigrationScriptsIfNeeded {
    [self configure];
    [self checkIfDatabaseVersionProvided];
    NSLog(@"checking if migration scripts should be run");
    
    NSInteger currentDbVersionNumber = [self getCurrentDbVersionNumber];
    NSLog(@"build version: %zd; current Db version: %zd", self.dbVersion, currentDbVersionNumber);
    
    if(self.dbVersion != currentDbVersionNumber){
        NSLog(@"Need to run migrations scripts from %zd to %zd", currentDbVersionNumber, self.dbVersion);
        if([self runMigrationScriptsFrom:currentDbVersionNumber to:self.dbVersion]) {
            // changing database version only if migration succeeded
            [self setCurrentDbVersionNumber:self.dbVersion];
        } else {
            [self execSqlFromUTF8String:"ROLLBACK"];
            [self closeDb];
            NSException *ex = [NSException
                    exceptionWithName:@"DatabaseMigrationFailedException"
                    reason:@"Given migration scripts don't exists or are incorrect"
                    userInfo:nil];
            @throw ex;
        }
    }
}

- (BOOL)runMigrationScriptsFrom:(NSInteger)fromVersion to:(NSInteger)toVersion {
    for(NSInteger i = fromVersion; i < toVersion; ++i){
        NSArray *scripts = [self.migrationScripts objectForKey:@(i)];

        if ([scripts count] > 0) {
            for (NSString *scriptName in scripts) {
                if([self fileExists:scriptName]){
                    NSLog(@"running migration script: %@", scriptName);
                    if (![self execContentOfFile:scriptName]) {
                        return NO;
                    }
                } else {
                    NSLog(@"WARNING, migration script %@ does not exist! Skipping it.", scriptName);
                    return NO;
                }
            }
        }  else {
            NSLog(@"No migration scripts defined from version %zd to version %zd", i, i+1);
        }    
    }
    return YES;
}

- (BOOL)execContentOfFile:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];

    NSError *err = nil;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    if (content == nil) {
        NSLog(@"%@", err);
        NSException *ex = [NSException
                    exceptionWithName:@"FileOpeningFailedException"
                    reason:@"Could not open a file or an encoding problem occurred"
                    userInfo:nil];
        @throw ex;
    }

    return [self execSqlFromUTF8String:[content UTF8String]];
}

- (BOOL)execSqlFromUTF8String:(const char *)content {
    char *errMsg;
    int result = sqlite3_exec([self getConnection], content, NULL, NULL, &errMsg);
    if (result != SQLITE_OK) {
        NSLog(@"%s", errMsg);
        sqlite3_free(errMsg);
        return NO;
    }
    return YES;
}

- (BOOL)fileExists:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    BOOL isDir = NO;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
}

- (NSInteger)getCurrentDbVersionNumber {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@", CURRENT_DB_VERSION_KEY];
    NSInteger versionNumber = [userDefaults integerForKey:key];
    NSLog(@"getCurrentDbVersionNumber %zd, for key: %@", versionNumber, key);
    return versionNumber;
}

- (void)setCurrentDbVersionNumber:(NSInteger)versionNumber {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@", CURRENT_DB_VERSION_KEY];
    [userDefaults setInteger:versionNumber forKey:key];
    [userDefaults synchronize];
    NSLog(@"setCurrentDbVersionNumber %zd, for key: %@", versionNumber, key);
}

- (void)checkIfDatabaseVersionProvided {
    if (self.dbVersion == -1) {
            NSException *ex = [NSException
                    exceptionWithName:@"NoDatabaseVersionGivenException"
                    reason:@"You did not provide database version in configure method"
                    userInfo:nil];
            @throw ex;
    }
}

- (BOOL)isInTransaction {
    return sqlite3_get_autocommit([self getConnection]) == 0;
}

@end
