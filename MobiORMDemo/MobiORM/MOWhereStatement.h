//
//  MOWhereStatement.h
//  Mobi ORM
//
//  Represents SQL queries having WHERE clause inside, like UPDATE, INSERT, DELETE.
//  Class is treated as an abstract one.
//

#import <Foundation/Foundation.h>
#import "MOTableExpression.h"

@class MOLExp;

extern NSString *const WHERE;

@interface MOWhereStatement : NSObject <MOExpression>

@property MOTableExpression *table;
@property MOLExp *where;

- (id)initWithTableExpression:(MOTableExpression *)table;

@end
