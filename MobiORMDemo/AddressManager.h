#import <Foundation/Foundation.h>
#import "PlaceDAO.h"
#import "AddressViewDAO.h"

@interface AddressManager : NSObject

- (NSString*)addressStringForPlace:(Place*)place;
- (AddressView*)addressViewForPlace:(Place*)place;
- (NSNumber*)insertAddress:(NSString*)addressName city:(NSString*)cityName country:(NSString*)countryName;
@end
