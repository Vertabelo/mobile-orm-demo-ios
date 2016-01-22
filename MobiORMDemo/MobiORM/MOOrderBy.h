//
//  MOOrderBy.h
//  Mobi ORM
//
//  Represents ORDER BY expression's argument in SQL query, for example:
//  first_column ASC. It does not contain 'ORDER BY' clause as a string.	
//

#import "MOExpression.h"
#import "MOColumn.h"

typedef enum {
    ASC,
    DESC
}
MOOrderByDirection;

@class MOAExp;

@interface MOOrderBy : NSObject <MOExpression>

+ (MOOrderBy *)orderByColumn:(MOAExp *)orderBy withDirection:(MOOrderByDirection)direction;

+ (MOOrderBy *)orderAscByColumn:(MOAExp *)orderBy;

+ (MOOrderBy *)orderDescByColumn:(MOAExp *)orderBy;

@end
