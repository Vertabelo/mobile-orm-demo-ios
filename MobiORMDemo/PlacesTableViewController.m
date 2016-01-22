#import "PlacesTableViewController.h"
#import "PlaceDetailsViewController.h"
#import "FilterPlacesViewController.h"
#import "AppDelegate.h"
#import "DemoSQLiteOpenHelper.h"
#import "MODAOProvider.h"
#import "AppDelegate.h"

@interface PlacesTableViewController ()

@property PlaceManager *placeManager;
@property NSArray *placesToShow;

-(void)showAddPlace:(id)sender;
-(void)showFilterPlaces:(id)sender;
-(void)cancelFilters:(id)sender;
-(void)drawButtons;

@end

@implementation PlacesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.tableView.rowHeight = 40;
    
    self.placeManager = [AppDelegate placeManager];
    if (!self.isFiltered) {
        self.placesToShow = [self.placeManager allPlaces];
    } else {
        self.placesToShow = [self.placeManager placesForFilterState:self.filterState];
    }
    [self.tableView reloadData];
    [self drawButtons];
}

-(void)showAddPlace:(id)sender {
    [self performSegueWithIdentifier:@"addPlace" sender:sender];
}

-(void)showFilterPlaces:(id)sender {
    [self performSegueWithIdentifier:@"filterPlaces" sender:sender];
}

-(void)cancelFilters:(id)sender {
    self.placesToShow = [self.placeManager allPlaces];
    self.isFiltered = NO;
    self.filterState = nil;
    [self drawButtons];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.placesToShow count];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    [self drawButtons];
    if (!self.isFiltered) {
        self.placesToShow = [self.placeManager allPlaces];
    } else {
        self.placesToShow = [self.placeManager placesForFilterState:self.filterState];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlacesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceItemCell" forIndexPath:indexPath];
    
    Place *place = [self.placesToShow objectAtIndex:indexPath.row];
    cell.placeLabel.text = place.columnName;
    cell.ratingLabel.text = [NSString stringWithFormat:@"Rating: %@/5", place.columnRating];
    
    return cell;
}

-(void)drawButtons {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddPlace:)];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showFilterPlaces:)];
    UIBarButtonItem *cancelFiltersButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelFilters:)];
    
    if (!self.isFiltered) {
        self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:addButton, filterButton, nil];
    } else {
        self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:addButton, filterButton, cancelFiltersButton, nil];
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Place *place = [self.placesToShow objectAtIndex:indexPath.row];
        [self.placeManager delete:place];
        self.placesToShow = [self.placeManager allPlaces];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPlaceDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PlaceDetailsViewController *destViewController = segue.destinationViewController;
        destViewController.place = [self.placesToShow objectAtIndex:indexPath.row];
    } else if ([segue.identifier isEqualToString:@"filterPlaces"]) {
        FilterPlacesViewController *destViewController = segue.destinationViewController;
        destViewController.filterState = self.filterState;
    }
}

@end
