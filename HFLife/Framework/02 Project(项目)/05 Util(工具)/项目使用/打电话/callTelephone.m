//
//  callTelephone.m
//  HanPay_Merchants
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "callTelephone.h"
@implementation callTelephone
+ (void) call:(NSString *)phoneNum{
    UIWebView *webV = [[UIWebView alloc] init];
    
    NSString *urlStr = [NSString stringWithFormat:@"tel:%@", phoneNum];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webV loadRequest:request];
    
    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
    if (!keyW) {
        keyW = [UIApplication sharedApplication].windows.lastObject;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:webV];
}
@end
