//
//  MODate.h
//  mobi-orm
//

#import <Foundation/Foundation.h>

@interface MODate : NSObject

@property NSUInteger year;
@property NSUInteger month;
@property NSUInteger day;

+ (MODate *)fromNSString:(NSString *)date;
+ (MODate *)fromNSDateComponents:(NSDateComponents *)date;
+ (MODate *)fromNSDate:(NSDate *)date;

- (NSString *)toNSString;
- (NSDateComponents *)toNSDateComponents;
- (NSDate *)toNSDate;

// checks if properties year, month and day are set
- (void)checkDateCorrectness;

- (BOOL)isEqualToMODate:(MODate *)date;

@end