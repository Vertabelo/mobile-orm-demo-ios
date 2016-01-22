//
//  MORowHandler.h
//  Mobi ORM
//
//  Protocol to conform to for row handlers.
//

#import <Foundation/Foundation.h>

@protocol MORowHandler <NSObject>

- (id)getObjectFromRow:(NSArray *)row;

@end
