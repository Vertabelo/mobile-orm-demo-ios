#import <UIKit/UIKit.h>

@interface EditTagsCollectionView : UICollectionView

@property NSMutableArray *tags;
- (IBAction)deleteTag:(UIButton *)sender;

@end
