//
//  MOValue.m
//  Mobi ORM
//

#import "MOValue.h"

@implementation MOValue

+ (MOValue *) value:(id)value withType:(MODbType)type {
    return [[MOValue alloc] initWithValue:value andType:type];
}

- (id)initWithValue:(id)value andType:(MODbType)type {
    self = [super init];
    
    if (self) {
        _value = value;
        _type = type;
    }
    return self;
}

@end
