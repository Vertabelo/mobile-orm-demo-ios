#import "FilterPlacesViewController.h"
#import "PlacesTableViewController.h"
#import "DemoSQLiteOpenHelper.h"
#import "AppDelegate.h"
#import "FilterState.h"

@interface FilterPlacesViewController ()

- (void)setFilter;

@property TagManager *tagManager;
@property PlaceManager *placeManager;
@property AddressManager *addressManager;

@property NSArray *countries;
@property NSArray *cities;
@property NSArray *addresses;

@end

@implementation FilterPlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagManager = [AppDelegate tagManager];
    self.placeManager = [AppDelegate placeManager];
    self.addressManager = [AppDelegate addressManager];
    
    if (self.filterState) {
        [self setFilter];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFilter {
    if (self.filterState.orderBy == NAME) {
        self.orderBy.selectedSegmentIndex = 0;
    } else if (self.filterState.orderBy == RATING) {
        self.orderBy.selectedSegmentIndex = 1;
    } else if (self.filterState.orderBy == ADDED) {
        self.orderBy.selectedSegmentIndex = 2;
    }
    if (self.filterState.isAscending) {
        self.isAscending.selectedSegmentIndex = 0;
    } else {
        self.isAscending.selectedSegmentIndex = 1;
    }
    
    self.minRating.selectedSegmentIndex = self.filterState.minRating - 1;
    self.maxRating.selectedSegmentIndex = self.filterState.maxRating - 1;
    self.address.text = self.filterState.address;
    self.city.text = self.filterState.city;
    self.country.text = self.filterState.country;
    self.tag.text = self.filterState.tag;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self.done) {
        PlacesTableViewController *destViewController = segue.destinationViewController;
        
        destViewController.isFiltered = YES;
        FilterState *filterState = [[FilterState alloc] init];
        filterState.minRating = self.minRating.selectedSegmentIndex + 1;
        filterState.maxRating = self.maxRating.selectedSegmentIndex + 1;
        filterState.address = self.address.text;
        filterState.city = self.city.text;
        filterState.country = self.country.text;
        filterState.tag = self.tag.text;
        
        switch (self.orderBy.selectedSegmentIndex) {
            case 0:
                filterState.orderBy = NAME;
                break;
            case 1:
                filterState.orderBy = RATING;
                break;
            case 2:
                filterState.orderBy = ADDED;
                break;
        }
        switch (self.isAscending.selectedSegmentIndex) {
            case 0:
                filterState.isAscending = YES;
                break;
            case 1:
                filterState.isAscending = NO;
                break;
        }
        
        destViewController.filterState = filterState;
    }
}

@end

