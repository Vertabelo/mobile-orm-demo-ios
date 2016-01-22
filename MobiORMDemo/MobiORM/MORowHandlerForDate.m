//
//  MORowHandlerForDate.m
//  Mobi ORM
//

#import "MORowHandlerForDate.h"

@implementation MORowHandlerForDate

- (id)getObjectFromRow:(NSArray *)row {
    return (NSDate *)row[0];
}

@end
