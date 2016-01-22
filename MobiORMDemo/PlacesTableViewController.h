#import <UIKit/UIKit.h>
#import "PlacesTableViewCell.h"
#import "MOLExp.h"
#import "MOColumn.h"
#import "FilterState.h"

@interface PlacesTableViewController : UITableViewController

@property FilterState *filterState;
@property BOOL isFiltered;
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
