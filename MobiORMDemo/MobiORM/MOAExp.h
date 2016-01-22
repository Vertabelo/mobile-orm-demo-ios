//
//  MOAExp.h
//  Mobi ORM
//
//  Represents arithmetical expression in SQL query.
//  Class is treated as an abstract one, use factory methods to create objects.
//

#import <Foundation/Foundation.h>
#import "MODbType.h"
#import "MOExpression.h"

@class MOSelectQuery;
@class MOLExp;

typedef enum {
    ADD,
    SUB,
    MUL,
    DIV
}
MODbOperator;

@interface MOAExp : NSObject <MOExpression>

+ (MOAExp *)fromBool:(BOOL)val;

+ (MOAExp *)fromInteger:(NSInteger)val;

+ (MOAExp *)withValue:(id)val type:(MODbType)type;

+ (MOAExp *)fromNumber:(NSNumber *)val;

+ (MOAExp *)fromString:(NSString *)val;

+ (MOAExp *)fromDate:(NSDate *)val;

+ (MOAExp *)fromData:(NSData *)val;

+ (MOAExp *)fromObject:(id)val;

+ (MOAExp *)withLeftAExp:(MOAExp *)left operator:(MODbOperator)operator
               rightAExp:(MOAExp *)right parentheses:(BOOL)parentheses;

+ (MOAExp *)add:(MOAExp *)left to:(MOAExp *)right;

+ (MOAExp *)subFrom:(MOAExp *)left value:(MOAExp *)right;

+ (MOAExp *)mul:(MOAExp *)left by:(MOAExp *)right;

+ (MOAExp *)div:(MOAExp *)left by:(MOAExp *)right;

+ (MOAExp *)neg:(MOAExp *)exp;

+ (MOAExp *)funWithName:(NSString *)name forArgument:(MOAExp *)arg;

+ (MOAExp *)funWithName:(NSString *)name forArguments:(NSArray *)args;

- (MOAExp *)addAExp:(MOAExp *)exp;

- (MOAExp *)addNumber:(NSNumber *)num;

- (MOAExp *)addString:(NSString *)num;

- (MOAExp *)addData:(NSData *)num;

- (MOAExp *)addDate:(NSDate *)num;

- (MOAExp *)addInteger:(NSInteger)num;

- (MOAExp *)add:(id)exp;

- (MOAExp *)subAExp:(MOAExp *)exp;

- (MOAExp *)subNumber:(NSNumber *)num;

- (MOAExp *)subString:(NSString *)num;

- (MOAExp *)subData:(NSData *)num;

- (MOAExp *)subDate:(NSDate *)num;

- (MOAExp *)subInteger:(NSInteger)num;

- (MOAExp *)sub:(id)exp;

- (MOAExp *)mulAExp:(MOAExp *)exp;

- (MOAExp *)mulNumber:(NSNumber *)num;

- (MOAExp *)mulString:(NSString *)num;

- (MOAExp *)mulData:(NSData *)num;

- (MOAExp *)mulDate:(NSDate *)num;

- (MOAExp *)mulInteger:(NSInteger)num;

- (MOAExp *)mul:(id)exp;

- (MOAExp *)divAExp:(MOAExp *)exp;

- (MOAExp *)divNumber:(NSNumber *)num;

- (MOAExp *)divString:(NSString *)num;

- (MOAExp *)divData:(NSData *)num;

- (MOAExp *)divDate:(NSDate *)num;

- (MOAExp *)divInteger:(NSInteger)num;

- (MOAExp *)div:(id)exp;

- (MOAExp *)neg;

- (MOAExp *)asArgumentOfFunction:(NSString *)name;

- (MOAExp *)putInParentheses;

- (MOLExp *)isEqualTo:(id)object;

- (MOLExp *)isEqualToExp:(MOAExp *)exp;

- (MOLExp *)isEqualToBool:(BOOL)boolean;

- (MOLExp *)isEqualToInteger:(NSInteger)integer;

- (MOLExp *)isEqualToString:(NSString *)string;

- (MOLExp *)isEqualToDate:(NSDate *)date;

- (MOLExp *)isEqualToData:(NSData *)data;

- (MOLExp *)isEqualToNumber:(NSNumber *)number;

- (MOLExp *)isEqualToQuery:(MOSelectQuery *)query;

- (MOLExp *)isNotEqualTo:(id)object;

- (MOLExp *)isNotEqualToExp:(MOAExp *)exp;

- (MOLExp *)isNotEqualToBool:(BOOL)boolean;

- (MOLExp *)isNotEqualToInteger:(NSInteger)integer;

- (MOLExp *)isNotEqualToString:(NSString *)string;

- (MOLExp *)isNotEqualToDate:(NSDate *)date;

- (MOLExp *)isNotEqualToData:(NSData *)data;

- (MOLExp *)isNotEqualToNumber:(NSNumber *)number;

- (MOLExp *)isNotEqualToQuery:(MOSelectQuery *)query;

- (MOLExp *)isGreaterThan:(id)object;

- (MOLExp *)isGreaterThanExp:(MOAExp *)exp;

- (MOLExp *)isGreaterThanBool:(BOOL)boolean;

- (MOLExp *)isGreaterThanInteger:(NSInteger)integer;

- (MOLExp *)isGreaterThanString:(NSString *)string;

- (MOLExp *)isGreaterThanDate:(NSDate *)date;

- (MOLExp *)isGreaterThanData:(NSData *)data;

- (MOLExp *)isGreaterThanNumber:(NSNumber *)number;

- (MOLExp *)isGreaterThanQuery:(MOSelectQuery *)query;

- (MOLExp *)isGreaterThanOrEqualTo:(id)object;

- (MOLExp *)isGreaterThanOrEqualToExp:(MOAExp *)exp;

- (MOLExp *)isGreaterThanOrEqualToBool:(BOOL)boolean;

- (MOLExp *)isGreaterThanOrEqualToInteger:(NSInteger)integer;

- (MOLExp *)isGreaterThanOrEqualToString:(NSString *)string;

- (MOLExp *)isGreaterThanOrEqualToDate:(NSDate *)date;

- (MOLExp *)isGreaterThanOrEqualToData:(NSData *)data;

- (MOLExp *)isGreaterThanOrEqualToNumber:(NSNumber *)number;

- (MOLExp *)isGreaterThanOrEqualToQuery:(MOSelectQuery *)query;

- (MOLExp *)isLessThanOrEqualTo:(id)object;

- (MOLExp *)isLessThanOrEqualToExp:(MOAExp *)exp;

- (MOLExp *)isLessThanOrEqualToBool:(BOOL)boolean;

- (MOLExp *)isLessThanOrEqualToInteger:(NSInteger)integer;

- (MOLExp *)isLessThanOrEqualToString:(NSString *)string;

- (MOLExp *)isLessThanOrEqualToDate:(NSDate *)date;

- (MOLExp *)isLessThanOrEqualToData:(NSData *)data;

- (MOLExp *)isLessThanOrEqualToNumber:(NSNumber *)number;

- (MOLExp *)isLessThanOrEqualToQuery:(MOSelectQuery *)query;

- (MOLExp *)isLessThan:(id)object;

- (MOLExp *)isLessThanExp:(MOAExp *)exp;

- (MOLExp *)isLessThanBool:(BOOL)boolean;

- (MOLExp *)isLessThanInteger:(NSInteger)integer;

- (MOLExp *)isLessThanString:(NSString *)string;

- (MOLExp *)isLessThanDate:(NSDate *)date;

- (MOLExp *)isLessThanData:(NSData *)data;

- (MOLExp *)isLessThanNumber:(NSNumber *)number;

- (MOLExp *)isLessThanQuery:(MOSelectQuery *)query;

- (MOLExp *)likeExp:(MOAExp *)exp;

- (MOLExp *)likeString:(NSString *)string;

- (MOLExp *)between:(id)lower and:(id)upper;

- (MOLExp *)betweenExp:(MOAExp *)lower and:(MOAExp *)upper;

- (MOLExp *)betweenInteger:(NSInteger)lower and:(NSInteger)upper;

- (MOLExp *)betweenNumber:(NSNumber *)lower and:(NSNumber *)upper;

- (MOLExp *)betweenString:(NSString *)lower and:(NSString *)upper;

- (MOLExp *)betweenDate:(NSDate *)lower and:(NSDate *)upper;

- (MOLExp *)isNull;

- (MOLExp *)isNotNull;

- (MOLExp *)in:(MOSelectQuery *)query;

- (MOLExp *)inArray:(NSArray *)array;

@end
