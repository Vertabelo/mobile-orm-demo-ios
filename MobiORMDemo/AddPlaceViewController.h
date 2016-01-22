#import <UIKit/UIKit.h>
#import "Place.h"
#import "EditTagsCollectionView.h"

@interface AddPlaceViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *placeName;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *save;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rating;
@property (weak, nonatomic) IBOutlet UITextView *comment;
- (IBAction)addTag:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet EditTagsCollectionView *tagsView;
- (IBAction)gallery:(UIButton *)sender;
@property Place *placeToEdit;

@end
