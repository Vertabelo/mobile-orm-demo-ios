//
//  MOAExpFunction.h
//  Mobi ORM
//
//  Represents arithmetical expression as function with arguments.
//  For example: COUNT(A)
// 
//  !!! This class is used internally by the code and its API may change,
//  to create logical expression use MOAExp class !!!
//

#import "MOAExp.h"

@interface MOAExpFunction : MOAExp

+ (MOAExp *)aExpAsFunctionNamed:(NSString *)name
                   forArguments:(NSArray *)arguments;

@end
