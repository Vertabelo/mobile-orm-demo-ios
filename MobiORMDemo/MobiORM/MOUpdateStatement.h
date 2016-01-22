//
//  MOUpdateStatement.h
//  Mobi ORM
//
//  Represents an SQL SELECT query.
//

#import <Foundation/Foundation.h>
#import "MOTableExpression.h"
#import "MOLExp.h"
#import "MOWhereStatement.h"

@interface MOUpdateStatement : MOWhereStatement

+ (MOUpdateStatement *)statementWithTableExpression:(MOTableExpression *)table;

- (id)initWithTableExpression:(MOTableExpression *)table;

- (void)updateColumn:(MOColumn *)column withValue:(id)value;

@end
