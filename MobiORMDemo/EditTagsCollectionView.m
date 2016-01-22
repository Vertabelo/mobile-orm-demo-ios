#import "EditTagsCollectionView.h"
#import "EditTagsCollectionViewCell.h"

@implementation EditTagsCollectionView

- (IBAction)deleteTag:(UIButton *)sender {
    EditTagsCollectionViewCell *cell = (EditTagsCollectionViewCell*)[[sender superview] superview];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    [self.tags removeObjectAtIndex:indexPath.row];
    [self reloadData];
}


@end
