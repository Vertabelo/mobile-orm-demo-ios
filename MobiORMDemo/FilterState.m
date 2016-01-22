#import "FilterState.h"
#import "AppDelegate.h"

@implementation FilterState

- (FilterState*)init {
    self = [super init];
    self.minRating = 1;
    self.maxRating = 5;
    self.address = @"";
    self.city = @"";
    self.country = @"";
    self.tag = @"";
    self.orderBy = NAME;
    self.isAscending = YES;
    return self;
}

@end
