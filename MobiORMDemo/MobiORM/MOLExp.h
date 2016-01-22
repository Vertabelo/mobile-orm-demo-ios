//
//  MOLExp.h
//  Mobi ORM
//
//  Represents a logical expression in SQL query.
//  Class is treated as an abstract one, use factory methods to create objects.
//

#import "MOExpression.h"
#import "MOAExp.h"

@class MOSelectQuery;

@interface MOLExp : NSObject <MOExpression>

+ (MOLExp *)trueExp;

+ (MOLExp *)falseExp;

+ (MOLExp *)exp:(MOAExp *)left like:(MOAExp *)right;

+ (MOLExp *)exp:(MOAExp *)exp between:(MOAExp *)left and:(MOAExp *)right;

+ (MOLExp *)exp:(MOAExp *)left isEqualTo:(MOAExp *)right;

+ (MOLExp *)boolean:(BOOL)left isEqualTo:(BOOL)right;

+ (MOLExp *)integer:(NSInteger)left isEqualTo:(NSInteger)right;

+ (MOLExp *)number:(NSNumber *)left isEqualTo:(NSNumber *)right;

+ (MOLExp *)string:(NSString *)left isEqualTo:(NSString *)right;

+ (MOLExp *)date:(NSDate *)left isEqualTo:(NSDate *)right;

+ (MOLExp *)data:(NSData *)left isEqualTo:(NSData *)right;

+ (MOLExp *)object:(id)left isEqualTo:(id)right;

+ (MOLExp *)exp:(MOAExp *)left isNotEqualTo:(MOAExp *)right;

+ (MOLExp *)boolean:(BOOL)left isNotEqualTo:(BOOL)right;

+ (MOLExp *)integer:(NSInteger)left isNotEqualTo:(NSInteger)right;

+ (MOLExp *)number:(NSNumber *)left isNotEqualTo:(NSNumber *)right;

+ (MOLExp *)string:(NSString *)left isNotEqualTo:(NSString *)right;

+ (MOLExp *)date:(NSDate *)left isNotEqualTo:(NSDate *)right;

+ (MOLExp *)data:(NSData *)left isNotEqualTo:(NSData *)right;

+ (MOLExp *)object:(id)left isNotEqualTo:(id)right;

+ (MOLExp *)exp:(MOAExp *)left isGreaterThan:(MOAExp *)right;

+ (MOLExp *)boolean:(BOOL)left isGreaterThan:(BOOL)right;

+ (MOLExp *)integer:(NSInteger)left isGreaterThan:(NSInteger)right;

+ (MOLExp *)number:(NSNumber *)left isGreaterThan:(NSNumber *)right;

+ (MOLExp *)string:(NSString *)left isGreaterThan:(NSString *)right;

+ (MOLExp *)date:(NSDate *)left isGreaterThan:(NSDate *)right;

+ (MOLExp *)data:(NSData *)left isGreaterThan:(NSData *)right;

+ (MOLExp *)object:(id)left isGreaterThan:(id)right;

+ (MOLExp *)exp:(MOAExp *)left isGreaterThanOrEqualTo:(MOAExp *)right;

+ (MOLExp *)boolean:(BOOL)left isGreaterThanOrEqualTo:(BOOL)right;

+ (MOLExp *)integer:(NSInteger)left isGreaterThanOrEqualTo:(NSInteger)right;

+ (MOLExp *)number:(NSNumber *)left isGreaterThanOrEqualTo:(NSNumber *)right;

+ (MOLExp *)string:(NSString *)left isGreaterThanOrEqualTo:(NSString *)right;

+ (MOLExp *)date:(NSDate *)left isGreaterThanOrEqualTo:(NSDate *)right;

+ (MOLExp *)data:(NSData *)left isGreaterThanOrEqualTo:(NSData *)right;

+ (MOLExp *)object:(id)left isGreaterThanOrEqualTo:(id)right;

+ (MOLExp *)exp:(MOAExp *)left isLessThanOrEqualTo:(MOAExp *)right;

+ (MOLExp *)boolean:(BOOL)left isLessThanOrEqualTo:(BOOL)right;

+ (MOLExp *)integer:(NSInteger)left isLessThanOrEqualTo:(NSInteger)right;

+ (MOLExp *)number:(NSNumber *)left isLessThanOrEqualTo:(NSNumber *)right;

+ (MOLExp *)string:(NSString *)left isLessThanOrEqualTo:(NSString *)right;

+ (MOLExp *)date:(NSDate *)left isLessThanOrEqualTo:(NSDate *)right;

+ (MOLExp *)data:(NSData *)left isLessThanOrEqualTo:(NSData *)right;

+ (MOLExp *)object:(id)left isLessThanOrEqualTo:(id)right;

+ (MOLExp *)exp:(MOAExp *)left isLessThan:(MOAExp *)right;

+ (MOLExp *)boolean:(BOOL)left isLessThan:(BOOL)right;

+ (MOLExp *)integer:(NSInteger)left isLessThan:(NSInteger)right;

+ (MOLExp *)number:(NSNumber *)left isLessThan:(NSNumber *)right;

+ (MOLExp *)string:(NSString *)left isLessThan:(NSString *)right;

+ (MOLExp *)date:(NSDate *)left isLessThan:(NSDate *)right;

+ (MOLExp *)data:(NSData *)left isLessThan:(NSData *)right;

+ (MOLExp *)object:(id)left isLessThan:(id)right;

+ (MOLExp *)exp:(MOLExp *)left and:(MOLExp *)right;

+ (MOLExp *)exp:(MOLExp *)left or:(MOLExp *)right;

+ (MOLExp *)notExp:(MOLExp *)exp;

+ (MOLExp *)isNullExp:(MOAExp *)exp;

+ (MOLExp *)isNotNullExp:(MOAExp *)exp;

+ (MOLExp *)exists:(MOSelectQuery *)query;

+ (MOLExp *)andArray:(NSArray *)expressionArray;

+ (MOLExp *)orArray:(NSArray *)expressionArray;

- (MOLExp *)not;

- (MOLExp *)and:(MOLExp *)exp;

- (MOLExp *)or:(MOLExp *)exp;

@end
