//
//  MORowHandlerForString.m
//  Mobi ORM
//

#import "MORowHandlerForString.h"

@implementation MORowHandlerForString

- (id)getObjectFromRow:(NSArray *)row {
    return (NSString *)row[0];
}

@end
