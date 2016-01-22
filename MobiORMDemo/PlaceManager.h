#import <Foundation/Foundation.h>
#import "PlaceDAO.h"
#import "TagDAO.h"
#import "FilterState.h"

@interface PlaceManager : NSObject

- (NSData*)imageForPlace:(Place*)place;
- (NSArray*)allPlaces;
- (void)delete:(Place*)place;
- (NSArray*)placesForFilterState:(FilterState*)filterState;
- (void)insertPlace:(Place*)place;
- (void)updatePlace:(Place*)place;
- (void)insertImage:(NSData*)image forPlace:(Place*)place;

@end
