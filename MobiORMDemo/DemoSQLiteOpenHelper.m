#import "DemoSQLiteOpenHelper.h"

@implementation DemoSQLiteOpenHelper

-(void)configure {
    self.dbVersion = 1;
    [self addCreateScript:@"MobiORM_Demo_create.sql"];
}

@end
