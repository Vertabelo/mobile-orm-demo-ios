//
//  MODate.m
//  mobi-orm
//

#import "MODate.h"

@interface MODate ()

- (NSString *)stringFromInteger:(NSUInteger)num withFixedLength:(NSUInteger)length;

@end

@implementation MODate

+ (MODate *)fromNSString:(NSString *)date {
    NSRange range = [date rangeOfString:@"^([0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])$" 
        options:NSRegularExpressionSearch];

    if (range.location != NSNotFound) {
        NSArray *parts = [date componentsSeparatedByString:@"-"];
        MODate *moDate = [[MODate alloc] init];
        moDate.year = [parts[0] integerValue];
        moDate.month = [parts[1] integerValue];
        moDate.day = [parts[2] integerValue];
        return moDate;
    } else {
        return nil;
    }
}

+ (MODate *)fromNSDateComponents:(NSDateComponents *)date {
    MODate *moDate = [[MODate alloc] init];
    moDate.year = date.year;
    moDate.month = date.month;
    moDate.day = date.day;
    return moDate;
}

+ (MODate *)fromNSDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components =  [gregorian components:(NSCalendarUnitYear
                                                             | NSCalendarUnitMonth
                                                             | NSCalendarUnitDay)
                                                fromDate:date];
    return [self fromNSDateComponents:components];
}

- (NSString *)toNSString {
    [self checkDateCorrectness];
    return [NSString stringWithFormat:@"%@-%@-%@",
        [self stringFromInteger:self.year withFixedLength:4],
        [self stringFromInteger:self.month withFixedLength:2],
        [self stringFromInteger:self.day withFixedLength:2]];
}

- (NSDateComponents *)toNSDateComponents {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    return components;
}

- (NSDate *)toNSDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [self toNSDateComponents];
    return [gregorian dateFromComponents:components];
}

- (void)checkDateCorrectness {
    if (self.year == 0 || self.month == 0 || self.day == 0) {
        NSException *ex = [NSException
                    exceptionWithName:@"IncorrectMODateFormat"
                    reason:@"Year, month and day have to be set."
                    userInfo:nil];
        @throw ex;
    }
}

- (NSString *)stringFromInteger:(NSUInteger)num withFixedLength:(NSUInteger)length {
    NSString *numStr = [NSString stringWithFormat:@"%tu", num];
    NSString *zeros = [@"" stringByPaddingToLength:length - [numStr length] withString:@"0"
                                                                       startingAtIndex:0];
    return [zeros stringByAppendingString:numStr];
}

- (BOOL)isEqualToMODate:(MODate *)date {
    if (!date) {
        return NO;
    }

    return self.year == date.year && self.month == date.month && self.day == date.day;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
      return YES;
    }

    if (![object isKindOfClass:[MODate class]]) {
      return NO;
    }

    return [self isEqualToMODate:(MODate *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + self.year;
    result = prime * result + self.month;
    result = prime * result + self.day;
    return result;
}

@end