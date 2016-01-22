#import <UIKit/UIKit.h>
#import "PlaceDAO.h"
#import "TagsCollectionView.h"

@interface PlaceDetailsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITextView *comment;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet TagsCollectionView *tagsView;
@property Place *place;

@end
