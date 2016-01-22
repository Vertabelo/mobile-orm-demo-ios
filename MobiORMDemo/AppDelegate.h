#import <UIKit/UIKit.h>
#import "MODAOProvider.h"
#import "AddressManager.h"
#import "TagManager.h"
#import "PlaceManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(MODAOProvider*)daoProvider;
+(AddressManager*)addressManager;
+(TagManager*)tagManager;
+(PlaceManager*)placeManager;

@end

