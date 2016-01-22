//
//  MOAExpFunction.m
//  Mobi ORM
//

#import "MOAExpFunction.h"

@interface MOAExpFunction ()

@property NSString *name;
@property NSArray *arguments;

@end

@implementation MOAExpFunction

+ (MOAExp *)aExpAsFunctionNamed:(NSString *)name
                   forArguments:(NSArray *)arguments {
    MOAExpFunction *result = [[MOAExpFunction alloc] init];
    result.name = name;
    result.arguments = arguments;
    return result;
}

- (NSString *)build {
    NSMutableString *result = [NSMutableString stringWithString:self.name];
    
    [result appendString:LP];
    
    for (id<MOExpression> exp in self.arguments) {
        [result appendString:[exp build]];
        [result appendString:COMMA];
    }
    
    if (self.arguments && [self.arguments count] > 0) {
        [result deleteCharactersInRange:
                            NSMakeRange([result length] - [COMMA length], 2)];
    }
    else {
        [result appendString:ASTERISK];
    }
    
    [result appendString:RP];
    
    return result;
}

- (NSMutableArray *)getParameters {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (MOAExp *aExp in self.arguments) {
        [result addObjectsFromArray:[aExp getParameters]];
    }
    
    return result;
}

@end
