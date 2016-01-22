//
//  MOExpression.h
//  Mobi ORM
//
//  Protocol for SQL expressions.
//

#import <Foundation/Foundation.h>
#import "MOExpressionConstants.h"

@protocol MOExpression <NSObject>

// returns correct SQL query with question marks for binding
- (NSString *)build;

// returns an array with objects of MOValue to bind them
- (NSArray *)getParameters;

@end
