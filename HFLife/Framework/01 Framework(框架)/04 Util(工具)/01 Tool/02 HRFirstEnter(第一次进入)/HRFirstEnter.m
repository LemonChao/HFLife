
#import "HRFirstEnter.h"

static NSString *USERDEFAULT_FIRST_ENTER_PROGRAM = @"USERDEFAULT_FIRST_ENTER_PROGRAM";

@implementation HRFirstEnter

+ (void)isFirst:(void(^)())handle {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_FIRST_ENTER_PROGRAM];
    if (value == nil || ![value boolValue]) {
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:USERDEFAULT_FIRST_ENTER_PROGRAM];
        handle();
    }
}

@end
