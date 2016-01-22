//
//  MOTableExpression.m
//  Mobi ORM
//

#import "MOTableExpression.h"

@class MOColumn;

@implementation MOTableExpression

+ (MOTableExpression *)tableWithName:(NSString *)name {
    return [[MOTableExpression alloc] initWithName:name];
}

- (id)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.columns = [[NSMutableArray alloc] init];
        self.blobColumns = [[NSMutableArray alloc] init];
        self.primaryKeyColumns = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addColumn:(MOColumn *)column {
    [self.columns addObject:column];
}

- (void)addColumnWithName:(NSString *)columnName type:(MODbType) type {
    [self.columns addObject:[[MOColumn alloc] initWithOwner:self name:columnName
                                                       type:type]];
}
     
- (void)addBlobColumn:(MOColumn *)column {
    [self.blobColumns addObject:column];
}

- (void)addBlobColumnWithName:(NSString *)columnName {
    [self.blobColumns addObject:[[MOColumn alloc] initWithOwner:self
                                                           name:columnName
                                                           type:BYTEA]];
}

- (void)addAsPrimaryKeyColumn:(MOColumn *)column {
    if (column.type == BYTEA) {
        [self addBlobColumn:column];
    } else {
        [self addColumn:column];
    }
    [self.primaryKeyColumns addObject:column];
}

- (void)addAsPrimaryKeyColumnWithName:(NSString *)columnName
                                 type:(MODbType)type {
    if (type == BYTEA) {
        [self addBlobColumnWithName:columnName];
    } else {
        [self addColumnWithName:columnName type:type];
    }
    
}

- (MOColumn *)getColumnWithName:(NSString *)name {
    
    for (MOColumn *col in self.columns) {
        if ([col.name isEqualToString:name]) {
            return col;
        }
    }
    
    for (MOColumn *col in self.blobColumns) {
        if ([col.name isEqualToString:name]) {
            return col;
        }
    }
    
    return nil;
}

- (NSString *)build {
    return [NSString stringWithFormat:@"\"%@\"", self.name];
}

- (NSArray *)getParameters {
    return [NSArray array];
}

- (id)init {
    return [self initWithName:nil];
}

@end
