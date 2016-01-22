#import <UIKit/UIKit.h>
#import "FilterState.h"

@interface FilterPlacesViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *minRating;
@property (strong, nonatomic) IBOutlet UISegmentedControl *maxRating;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *done;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UISegmentedControl *orderBy;
@property (strong, nonatomic) IBOutlet UISegmentedControl *isAscending;
@property (strong, nonatomic) IBOutlet UITextField *tag;
@property FilterState *filterState;

@end
