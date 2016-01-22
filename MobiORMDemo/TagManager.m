#import "TagManager.h"
#import "PlaceDAO.h"
#import "PlaceTagDAO.h"
#import "TagDAO.h"
#import "MODAOProvider.h"
#import "AppDelegate.h"

@interface TagManager ()

@property PlaceDAO *placeDAO;
@property PlaceTagDAO *placeTagDAO;
@property TagDAO *tagDAO;

@end

@implementation TagManager

- (TagManager*)init {
    self = [super init];
    MODAOProvider *daoProvider = [AppDelegate daoProvider];
    self.placeDAO = [daoProvider placeDAO];
    self.placeTagDAO = [daoProvider placeTagDAO];
    self.tagDAO = [daoProvider tagDAO];
    return self;
}

- (NSArray*)tagsForPlace:(Place*)place {
    NSArray *placeTags = [self.placeTagDAO getPlaceTagArrayWhere:[self.placeTagDAO.PLACE_ID isEqualToNumber:place.columnId]];
    NSMutableArray *tagsNames = [[NSMutableArray alloc] init];
    for (PlaceTag *placeTag in placeTags) {
        [tagsNames addObject:placeTag.columnTagName];
    }
    return [self.tagDAO getTagArrayWhere:[self.tagDAO.NAME inArray:tagsNames]];
}

- (void)insertOrUpdateTags:(NSArray *)tags forPlace:(Place *)place {
    [self.placeTagDAO deleteWhere:[self.placeTagDAO.PLACE_ID isEqualToNumber:place.columnId]];
    
    for (NSString *t in tags) {
        Tag *tag = [self.tagDAO getByName:t];
        if (tag == nil) {
            Tag *newTag = [Tag tag];
            newTag.columnName = t;
            [self.tagDAO insertTag:newTag];
        }
        PlaceTag *placeTag = [PlaceTag placeTag];
        placeTag.columnTagName = t;
        placeTag.columnPlaceId = place.columnId;
        
        [self.placeTagDAO insertPlaceTag:placeTag];
    }
}

@end
