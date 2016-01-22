#import "AddressManager.h"
#import "AddressDAO.h"
#import "CityDAO.h"
#import "CountryDAO.h"
#import "AddressViewDAO.h"
#import "MODAOProvider.h"
#import "AppDelegate.h"

@interface AddressManager ()

@property AddressDAO *addressDAO;
@property CityDAO *cityDAO;
@property CountryDAO *countryDAO;
@property AddressViewDAO *addressViewDAO;


@end

@implementation AddressManager

- (AddressManager*)init {
    self = [super init];
    MODAOProvider *daoProvider = [AppDelegate daoProvider];
    self.addressDAO = [daoProvider addressDAO];
    self.cityDAO = [daoProvider cityDAO];
    self.countryDAO = [daoProvider countryDAO];
    self.addressViewDAO = [daoProvider addressViewDAO];
    return self;
}

- (NSString*)addressStringForPlace:(Place*)place {
    AddressView *addressView = [self addressViewForPlace:place];
    if ([addressView.columnAddress length] > 0) {
        return [NSString stringWithFormat:@"%@, %@, %@", addressView.columnAddress, addressView.columnCityName, addressView.columnCountryName];
    } else {
        return [NSString stringWithFormat:@"%@, %@", addressView.columnCityName, addressView.columnCountryName];
    }
}

- (AddressView*)addressViewForPlace:(Place*)place {
    return [[self.addressViewDAO getAddressViewArrayWhere:[self.addressViewDAO.ADDRESS_ID isEqualToNumber:place.columnId]] objectAtIndex:0];
}

- (void)tryInsertCountryWithName:(NSString*)name {
    Country *country = [self.countryDAO getByName:name];
    if (country == nil) {
        country = [Country country];
        country.columnName = name;
        [self.countryDAO insertCountry: country];
    }
}

- (NSNumber*)insertAddress:(NSString*)addressName city:(NSString*)cityName country:(NSString*)countryName {
    Country *country = [self.countryDAO getByName:countryName];
    if (country == nil) {
        country = [Country country];
        country.columnName = countryName;
        [self.countryDAO insertCountry: country];
    }
    
    City *city = [self.cityDAO getByCountryId:country.columnId name:cityName];
    if (city == nil) {
        city = [City city];
        city.columnName = cityName;
        city.columnCountryId = country.columnId;
        [self.cityDAO insertCity: city];
    }
    
    Address *address;
    if (![addressName isEqualToString: @""]) {
        MOSelectQuery* query = [MOSelectQuery selectFromTable:self.addressDAO.TABLE_EXPRESSION];
        query.where = [[self.addressDAO.ADDRESS isEqualToString:addressName] and:[self.addressDAO.CITY_ID isEqualToNumber:city.columnId]];
        address = [self.addressDAO selectOne:query];
    }
    if (address == nil) {
        address = [Address address];
        address.columnAddress = addressName;
        address.columnCityId = city.columnId;
        [self.addressDAO insertAddress:address];
    }
    return address.columnId;
}

@end
