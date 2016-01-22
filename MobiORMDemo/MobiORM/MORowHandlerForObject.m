//
//  MORowHandlerForObject.m
//  Mobi ORM
//

#import "MORowHandlerForObject.h"

@implementation MORowHandlerForObject

- (id)getObjectFromRow:(NSArray *)row {
    return row[0];
}

@end
