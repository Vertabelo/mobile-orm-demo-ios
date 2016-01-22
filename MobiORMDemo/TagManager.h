#import <Foundation/Foundation.h>
#import "PlaceDAO.h"
#import "TagDAO.h"

@interface TagManager : NSObject

- (NSArray*)tagsForPlace:(Place*)place;
- (void)insertOrUpdateTags:(NSArray*)tags forPlace:(Place*)place;

@end
