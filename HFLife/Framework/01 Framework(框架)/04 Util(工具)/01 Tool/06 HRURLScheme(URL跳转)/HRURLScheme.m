

#import "HRURLScheme.h"
#import <UIKit/UIKit.h>

@implementation HRURLScheme

//访问系统app（含系统设置界面等）
+ (void)openSystemApp:(NSString *)urlScheme {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlScheme]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlScheme] options:@{} completionHandler:nil];
    } else {
        NSLog(@"\"%@\"-URL无法访问", urlScheme);
    }
}
//访问其他app
+ (void)openOtherApp:(NSString *)urlScheme {
    NSString *urlStr = [NSString stringWithFormat:@"%@://", urlScheme];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
    } else {
        NSLog(@"\"%@\"-URL无法访问", urlScheme);
    }
}

@end







