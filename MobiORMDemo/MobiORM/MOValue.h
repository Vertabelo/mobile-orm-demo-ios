//
//  MOValue.h
//  Mobi ORM
//
//  Tuple to store value and type.
//

#import <Foundation/Foundation.h>
#import "MODbType.h"

@interface MOValue : NSObject

@property (readonly) id value;
@property (readonly) MODbType type;

+ (MOValue *)value:(id)value withType:(MODbType)type;

- (id)initWithValue:(id)value andType:(MODbType)type;

@end
