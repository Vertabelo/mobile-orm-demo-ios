//
//  MODeleteStatement.h
//  Mobi ORM
//
//  Represents an SQL DELETE statement.
//

#import <Foundation/Foundation.h>
#import "MOTableExpression.h"
#import "MOWhereStatement.h"

@interface MODeleteStatement : MOWhereStatement

+ (MODeleteStatement *)statementWithTableExpression:(MOTableExpression *)table;

@end
