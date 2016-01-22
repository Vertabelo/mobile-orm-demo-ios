//
//  MOAsterisk.h
//  Mobi ORM
//
//  Virtual column representing an asterisk from queries like:
//  SELECT * FROM, COUNT(*) etc.
//

#import <Foundation/Foundation.h>
#import "MOExpression.h"

@interface MOAsterisk : NSObject <MOExpression>
@end
