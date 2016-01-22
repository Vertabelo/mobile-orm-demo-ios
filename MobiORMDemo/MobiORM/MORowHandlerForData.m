//
//  MORowHandlerForData.m
//  Mobi ORM
//

#import "MORowHandlerForData.h"

@implementation MORowHandlerForData

- (id)getObjectFromRow:(NSArray *)row {
    return (NSData *)row[0];
}

@end
