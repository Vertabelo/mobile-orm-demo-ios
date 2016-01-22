//
//  MOLExpBoth.m
//  Mobi ORM
//

#import "MOLExpBoth.h"
#import "MOLExpParentheses.h"

@interface MOLExpBoth ()

@property id<MOExpression> left;
@property NSString *operator;
@property id<MOExpression> right;

@end

@implementation MOLExpBoth

+ (MOLExp *)lExpWithLeft:(id<MOExpression>)left operator:(NSString *)operator
                   right:(id<MOExpression>)right parentheses:(BOOL)parentheses {
    MOLExpBoth *result = [[MOLExpBoth alloc] initWithLeft:left operator:operator
                                                    right:right];
    
    if (parentheses) {
        return [MOLExpParentheses getInParenthesesExpression:result];
    }
    return result;
}

- (id)initWithLeft:(id<MOExpression>)left operator:(NSString *)operator
             right:(id<MOExpression>)right {
    self = [super init];
    
    if (self) {
        self.left = left;
        self.operator = operator;
        self.right = right;
    }
    return self;
}

- (NSString *)build {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:[self.left build]];
    [result appendString:self.operator];
    [result appendString:[self.right build]];
    
    return result;
}

- (NSMutableArray *)getParameters {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObjectsFromArray:[self.left getParameters]];
    [parameters addObjectsFromArray:[self.right getParameters]];
    return parameters;
}

@end
