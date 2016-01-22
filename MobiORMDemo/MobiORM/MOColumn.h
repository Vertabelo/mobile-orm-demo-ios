//
//  MOColumn.h
//  Mobi ORM
//
//  Represents column in an SQL query.
//

#import <Foundation/Foundation.h>
#import "MOTableExpression.h"
#import "MODbType.h"
#import "MOAExp.h"

@class MOTableExpression;

@interface MOColumn : MOAExp <NSCopying>

@property (readonly, weak) MOTableExpression *owner;
@property (readonly) NSString *name;
@property (readonly) MODbType type;

+ (MOColumn *)columnWithOwner:(MOTableExpression *)table name:(NSString *)name
                         type:(MODbType)type;

//return asterisk column for queries like select * from, count(*)
+ (id<MOExpression>)asterisk;

- (id)initWithOwner:(MOTableExpression *)table name:(NSString *)name
               type:(MODbType)type;

//to build correct insert and update queries
- (NSString *)buildWithoutTableDotPrefix;

@end
