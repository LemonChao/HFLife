
#import "HRCall.h"
#import <UIKit/UIKit.h>

@implementation HRCall

+ (void)phoneNumber:(NSString *)phoneNumber alert:(BOOL)alert {
    NSString *url = @"";
    if (alert) {
        url = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
    } else {
        url = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    }
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}


@end
