
//
//  HF_PayHelp.m
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "HF_PayHelp.h"

@implementation HF_PayHelp


+ (void) goWXPay:(NSString *)wxCode{
    if ([WXApi isWXAppInstalled]) {
//        NSString *str = [NSString stringWithFormat:@"weixin://qr/%@", wxCode];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wxCode]];
        
        
        
        //或者用 test一下
        OpenWebviewReq *req = [[OpenWebviewReq alloc]init];
        req.openID = WX_APP_ID;
        req.type = 1;
        req.url =  @"http://www.baidu.com";
        [WXApi sendReq:req];
        
        
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装微信，现在去安装" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}







@end
