//
//  MOAExpList.h
//  Mobi ORM
//
//  Represents list of arithmetical expression, used in IN operations.
//

#import <Foundation/Foundation.h>
#import "MOAExp.h"

@interface MOAExpList : MOAExp

+ (MOAExp *)getAExpListFromArray:(NSArray *)array;

@end
