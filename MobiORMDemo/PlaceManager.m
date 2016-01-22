#import "PlaceManager.h"
#import "PlaceDAO.h"
#import "PlaceTagDAO.h"
#import "MODAOProvider.h"
#import "AppDelegate.h"
#import "PlaceDAO.h"
#import "MOLExp.h"
#import "MOSelectQuery.h"

@interface PlaceManager ()

@property PlaceDAO *placeDAO;
@property PlaceTagDAO *placeTagDAO;
@property AddressViewDAO *addressViewDAO;

@end

@implementation PlaceManager

- (PlaceManager*)init {
    self = [super init];
    MODAOProvider *daoProvider = [AppDelegate daoProvider];
    self.placeDAO = [daoProvider placeDAO];
    self.placeTagDAO = [daoProvider placeTagDAO];
    self.addressViewDAO = [daoProvider addressViewDAO];
    return self;
}

- (NSData*)imageForPlace:(Place*)place {
    return [self.placeDAO getImageForPlace:place];
}

- (NSArray*)allPlaces {
    return [self.placeDAO getPlaceArray];
}

- (void)delete:(Place*)place {
    [self.placeDAO deletePlace:place];
}

- (NSArray*)placesForFilterState:(FilterState*)filterState {
    MOLExp *where = [[self.placeDAO.RATING isGreaterThanOrEqualToInteger:filterState.minRating] and:[self.placeDAO.RATING isLessThanOrEqualToInteger:filterState.maxRating]];
    
    MOLExp *addressLExp = [MOLExp trueExp];
    
    if ([filterState.country length] > 0) {
        addressLExp = [addressLExp and:[self.addressViewDAO.COUNTRY_NAME isEqualToString:filterState.country]];
    }

    if ([filterState.city length] > 0) {
        addressLExp = [addressLExp and:[self.addressViewDAO.CITY_NAME isEqualToString:filterState.city]];
    }

    if ([filterState.address length] > 0) {
        addressLExp = [addressLExp and:[self.addressViewDAO.ADDRESS isEqualToString:filterState.address]];
    }
    
    NSArray *addressViews = [self.addressViewDAO getAddressViewArrayWhere:addressLExp];
    NSMutableArray *addressIds = [[NSMutableArray alloc] init];
    for (AddressView *addressView in addressViews) {
        [addressIds addObject:addressView.columnAddressId];
    }
    
    where = [where and:[self.placeDAO.ADDRESS_ID inArray:addressIds]];
    
    if ([filterState.tag length] > 0) {
        NSArray *placeTags = [self.placeTagDAO getPlaceTagArrayWhere:[self.placeTagDAO.TAG_NAME isEqualToString:filterState.tag]];
        NSMutableArray *placeIds = [[NSMutableArray alloc] init];
        for (PlaceTag *placeTag in placeTags) {
            [placeIds addObject:placeTag.columnPlaceId];
        }
        where = [where and:[self.placeDAO.ID inArray:placeIds]];
    }
    
    MOColumn *filterColumn;
    
    switch (filterState.orderBy) {
        case NAME:
            filterColumn = self.placeDAO.NAME;
            break;
            
        case RATING:
            filterColumn = self.placeDAO.RATING;
            break;
            
        case ADDED:
            filterColumn = self.placeDAO.ADDED;
            break;
            
        default:
            break;
    }
    
    return filterState.isAscending? [self.placeDAO getPlaceArrayWhere:where orderAscByColumn:filterColumn] :
            [self.placeDAO getPlaceArrayWhere:where orderDescByColumn:filterColumn];
}

- (void)insertPlace:(Place*)place {
    [self.placeDAO insertPlace:place];
}

- (void)updatePlace:(Place *)place {
    [self.placeDAO updatePlace:place];
}

- (void)insertImage:(NSData*)image forPlace:(Place*)place {
    [self.placeDAO setImage:image forPlace:place];
}
@end
