//
//  MORowHandlerForNumber.m
//  Mobi ORM
//

#import "MORowHandlerForNumber.h"

@implementation MORowHandlerForNumber

- (id)getObjectFromRow:(NSArray *)row {
    return (NSNumber *)row[0];
}

@end
