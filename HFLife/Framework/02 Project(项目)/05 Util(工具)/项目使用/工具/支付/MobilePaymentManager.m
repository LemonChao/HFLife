//
//  MobilePaymentManager.m
//  healthManagement
//
//  Created by MATRIX on 15/11/20.
//  Copyright © 2015年 renqing. All rights reserved.
//

#import "MobilePaymentManager.h"
#import "UPPaymentControl.h"

@implementation MobilePaymentManager

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayFinished:) name:WECHAT_PAY_FINISH_NOTIFICATION object:nil];
        
    }
    return self;
}
+ (MobilePaymentManager *)sharedManager
{
    static MobilePaymentManager *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MobilePaymentManager alloc] init];
        [WXApi registerApp:WX_APP_ID];
    });
    
    return _sharedInstance;
}
- (void)wechatPayWithParams:(NSDictionary *)dataDict
                     finish:(void (^)(int))payFinish
{
    // 检测是否安装有微信
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"您还未安装微信");
        [WXZTipView showCenterWithText:@"您还未安装微信"];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    WeChatPayNetApi *wePay = [[WeChatPayNetApi alloc]initWithParameter:dataDict];
    [wePay startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        WeChatPayNetApi *payResult = (WeChatPayNetApi *)request;
        if ([[payResult getContent] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)[payResult getContent];
            NSDictionary *dicResponse = response[@"info"];
            if ([dicResponse isKindOfClass:[NSDictionary class]]){
                self->_wechatPayFinish = payFinish;
                    //调起微信支付
                PayReq *req   = [[PayReq alloc] init];
                req.openID    = [dicResponse objectForKey:@"appid"];
                req.partnerId = [dicResponse objectForKey:@"partnerid"];
                req.prepayId  = [dicResponse objectForKey:@"prepayid"];
                req.nonceStr  = [dicResponse objectForKey:@"noncestr"];
                req.timeStamp = [[dicResponse objectForKey:@"timestamp"] intValue];
                req.package   = [dicResponse objectForKey:@"package"];
                req.sign      = [dicResponse objectForKey:@"sign"];
                [WXApi sendReq:req];
            }else{
                [WXZTipView showCenterWithText:response[@"mas"]];
            }
        }else{
            [WXZTipView showCenterWithText:@"数据请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
       [WXZTipView showCenterWithText:@"订单生成错误"];
    }];
}

- (void)wechatPayFinished:(NSNotification *)notification
{
    int errCode = [notification.userInfo[WECHAT_RESP_CODE] intValue];
    if (_wechatPayFinish) {
        _wechatPayFinish(errCode);
    }
}



- (void)AlipayPaycompleteParams:(NSMutableDictionary *)dataDict  payFinish:(void (^)(int))payFinish{
     _wechatPayFinish = payFinish;
    AlipayPaymentNetApi *version = [[AlipayPaymentNetApi alloc]initWithParameter:dataDict];
    [version startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AlipayPaymentNetApi *payResult = (AlipayPaymentNetApi *)request;
        if ([[payResult getContent] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)[payResult getContent];
            NSString *dataString = response[@"info"];
            if (![NSString  isNOTNull:dataString]){
                NSString *appScheme = @"BanGuoAlipay";
                [[AlipaySDK defaultService] payOrder:dataString fromScheme:appScheme callback:^(NSDictionary *resultDic){
                    NSLog(@"==============================reslut = %@",resultDic);
                    NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
                    payFinish([resultStatus intValue]);
                }];
                
            }else{
					payFinish(4000);
            }
            
        }else{
            payFinish(4000);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        payFinish(4000);
    }];
    

}
//银联支付
-(void)UPPaySartPay:(NSString*)tn payFinish:(void (^)(int))payFinish{
#ifdef DEBUG
    NSString *model = @"01";
#else
    NSString *model = @"00";
#endif
     _wechatPayFinish = payFinish;
    [[UPPaymentControl defaultControl]startPay:tn fromScheme:@"UPPay_HanPay" mode:model viewController:[self topViewController]];
}

/**
 *  授权回调
 */
-(BOOL)handleOpenURL:(NSURL *)url{
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *code=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                if (self->_wechatPayFinish) {
                    self->_wechatPayFinish([code intValue]);
                }
            });
            
        }];
        return YES;
    }
    if([url.host isEqualToString:@"uppayresult"]){
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            int codeInt = -1;
            if([code isEqualToString:@"success"]) {
                //交易成功
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"YINLIANPAYS" object:nil];
                codeInt = 0;
            }else if([code isEqualToString:@"fail"]) {
                //交易失败
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"YINLIANPAYF" object:nil];
                codeInt = -1;
            }else if([code isEqualToString:@"cancel"]) {
                //交易取消
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"YINLIANPAYC" object:nil];
                codeInt = -2;
            }
            // UI更新代码
            if (self->_wechatPayFinish) {
                self->_wechatPayFinish(codeInt);
            }
        }];
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark - WXApiDelegate(optional)
-(void) onReq:(BaseReq*)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        
        if (_wechatPayFinish) {
            _wechatPayFinish(resp.errCode);
        }
    }
    
}

#pragma mark 获取当前显示的VC
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
