//
//  MOInsertStatement.h
//  Mobi ORM
//
//  Represents an SQL INSERT statement.
//

#import <Foundation/Foundation.h>
#import "MOTableExpression.h"

@interface MOInsertStatement : NSObject <MOExpression>

+ (MOInsertStatement *)statementWithTableExpression:(MOTableExpression *)table;

- (id)initWithTableExpression:(MOTableExpression *)table;

- (void)addColumn:(MOColumn *)column withValue:(id)value;

@end
