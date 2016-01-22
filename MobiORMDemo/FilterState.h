#import <Foundation/Foundation.h>
#import "MOColumn.h"

typedef enum orderByColumn {
    NAME,
    RATING,
    ADDED
} OrderByColumn;

@interface FilterState : NSObject

@property NSInteger minRating;
@property NSInteger maxRating;
@property NSString *address;
@property NSString *city;
@property NSString *country;
@property NSString *tag;
@property OrderByColumn orderBy;
@property BOOL isAscending;

@end
