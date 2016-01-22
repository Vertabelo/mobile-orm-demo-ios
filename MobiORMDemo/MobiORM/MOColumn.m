//
//  MOColumn.m
//  Mobi ORM
//

#import "MOColumn.h"
#import "MOAsterisk.h"

@implementation MOColumn

+ (MOColumn *)columnWithOwner:(MOTableExpression *)table name:(NSString *)name
                         type:(MODbType)type {
    return [[MOColumn alloc] initWithOwner:table name:name type:type];
}


+ (id<MOExpression>)asterisk {
    return [[MOAsterisk alloc] init];
}

- (id)initWithOwner:(MOTableExpression *)owner name:(NSString *)name
               type:(MODbType)type {
    self = [super init];
    
    if (self) {
        _owner = owner;
        _name = name;
        _type = type;
    }
    return self;
}


- (NSString *)buildWithoutTableDotPrefix {
    return self.name;
}

- (NSString *)build {
    return [NSString stringWithFormat:@"%@.%@", [self.owner build],
                                                                self.name];
}

- (NSMutableArray *)getParameters {
    return [NSMutableArray arrayWithArray:[self.owner getParameters]];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] initWithOwner:self.owner
                                                       name:self.name
                                                       type:self.type];;
}

@end
