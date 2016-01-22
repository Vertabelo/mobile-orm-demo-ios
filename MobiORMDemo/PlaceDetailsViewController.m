#import "PlaceDetailsViewController.h"
#import "AddPlaceViewController.h"
#import "PlaceManager.h"
#import "TagManager.h"
#import "AddressManager.h"
#import "DemoSQLiteOpenHelper.h"
#import "MOSelectQuery.h"
#import "TagsCollectionViewCell.h"
#import "PlacesTableViewController.h"
#import "AppDelegate.h"
#import "MODAOProvider.h"

@interface PlaceDetailsViewController ()

@property PlaceManager *placeManager;
@property AddressManager *addressManager;
@property TagManager *tagManager;

@end

@implementation PlaceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.placeManager = [AppDelegate placeManager];
    self.tagManager = [AppDelegate tagManager];
    self.addressManager = [AppDelegate addressManager];
    
    self.name.text = self.place.columnName;
    self.rating.text = [NSString stringWithFormat:@"%@/5", self.place.columnRating];
    
    [self.image.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.image.layer setBorderWidth:0.4];
    
    self.address.text = [self.addressManager addressStringForPlace:self.place];
    
    if (self.place.columnComment) {
        self.comment.text = self.place.columnComment;
    } else {
        self.comment.text = @"-";
    }
    self.comment.textAlignment = NSTextAlignmentCenter;
    
    NSData *data = [self.placeManager imageForPlace:self.place];
    if (![data isKindOfClass: [NSNull class]]) {
        self.image.image = [UIImage imageWithData:data];
    }
    
    self.tagsView.tags = [self.tagManager tagsForPlace:self.place];
    
    self.tagsView.delegate = self;
    self.tagsView.dataSource = self;
    [self.tagsView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editPlace"]) {
        AddPlaceViewController *destViewController = segue.destinationViewController;
        destViewController.placeToEdit = self.place;
    } else if ([segue.identifier isEqualToString:@"showPlacesWithTag"]) {
        PlacesTableViewController *destViewController = segue.destinationViewController;
        destViewController.isFiltered = YES;
        FilterState *filterState = [[FilterState alloc] init];
        UIButton *button = (UIButton*)sender;
        filterState.tag = button.titleLabel.text;
        destViewController.filterState = filterState;
    }
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.tagsView.tags count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagsCollectionViewCell *cell = [self.tagsView dequeueReusableCellWithReuseIdentifier:@"tagCell" forIndexPath:indexPath];
    Tag *tag = [self.tagsView.tags objectAtIndex:indexPath.row];
    [cell.tagButton setTitle:tag.columnName forState:UIControlStateNormal];
    return cell;
}

@end
