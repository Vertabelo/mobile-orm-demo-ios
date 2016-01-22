//
//  MOExpressionConstants.h
//  Mobi ORM
//
//  Constants used for building SQL queries.
//

#import <Foundation/Foundation.h>

static NSString *const QUESTION_MARK = @"?";
static NSString *const SPACE = @" ";
static NSString *const COMMA = @", ";
static NSString *const DOT = @".";
static NSString *const ASTERISK = @"*";
static NSString *const LP = @"(";
static NSString *const RP = @")";
static NSString *const MINUS = @"-";

//constans for arithmetical expressions
static NSString *const EQ = @" = ";
static NSString *const NE = @" <> ";
static NSString *const GT = @" > ";
static NSString *const GE = @" >= ";
static NSString *const LT = @" < ";
static NSString *const LE = @" <= ";

//constans for logical expressions
static NSString *const AND = @" AND ";
static NSString *const OR = @" OR ";
static NSString *const NOT = @"NOT ";
static NSString *const IS_NULL = @" IS NULL";
static NSString *const IS_NOT_NULL = @" IS NOT NULL";
static NSString *const LIKE = @" LIKE ";
static NSString *const IN = @" IN ";
static NSString *const BETWEEN = @" BETWEEN ";
static NSString *const EXISTS = @"EXISTS ";
