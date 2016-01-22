//
//  MOSubselect.h
//  Mobi ORM
//
//  Subselect expression used to build queries.
//

#import "MOAExp.h"
#import "MOSelectQuery.h"

@interface MOSubselect : MOAExp

@property MOSelectQuery *query;

+ (MOSubselect *)subselect:(MOSelectQuery *)query;

- (id)initWithSelect:(MOSelectQuery *)query;

@end
