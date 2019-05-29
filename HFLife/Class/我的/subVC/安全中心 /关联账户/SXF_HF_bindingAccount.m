
//
//  SXF_HF_bindingAccount.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_bindingAccount.h"
#import "SXF_HF_exchangePhoneVc.h"
@interface SXF_HF_bindingAccount ()

@end

@implementation SXF_HF_bindingAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"关联账号";
    self.wechatStateLabel.text = [userInfoModel sharedUser].weixin_unionid ? @"已绑定":@"未绑定";
    self.alipayStateLabel.text = [userInfoModel sharedUser].alipay_unionid ? @"已绑定":@"未绑定";
    self.phoneNumLabel.text = [[userInfoModel sharedUser].member_mobile EncodeTel];
    
}


//微信
- (IBAction)tapWechatCell:(UITapGestureRecognizer *)sender {
    
    if ([userInfoModel sharedUser].weixin_unionid) {
        //解绑
        [SXF_HF_AlertView showAlertType:AlertType_binding Complete:^(BOOL btnBype) {
            if (btnBype) {
                
                [[WBPCreate sharedInstance]showWBProgress];
                [networkingManagerTool requestToServerWithType:POST withSubUrl:kMobileRemoveWx withParameters:nil withResultBlock:^(BOOL result, id value) {
                    [[WBPCreate sharedInstance]hideAnimated];
                    if (result) {
                        [userInfoModel sharedUser].weixin_unionid = nil;
                        SXF_HF_AlertView *alert =  [SXF_HF_AlertView showAlertType:(AlertType_exchnageSuccess) Complete:nil];
                        alert.title = @"解绑成功";
                        self.wechatStateLabel.text = @"未绑定";
                        
                    }else {
                        if (value && [value isKindOfClass:[NSDictionary class]]) {
                            [WXZTipView showCenterWithText:value[@"msg"]];
                        }else {
                            [WXZTipView showCenterWithText:@"网络错误"];
                        }
                    }
                }];
                
            }
        }];
    }
    else {
        //绑定微信
        [[WBPCreate sharedInstance] showWBProgress];
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
                   [[WBPCreate sharedInstance] hideAnimated];
                   if (state == SSDKResponseStateSuccess){
                       NSDictionary *dataDict = @{@"openid":user.uid,@"nickname":user.nickname,@"user_headimg":user.icon,@"sex":@(user.gender)};
                       [[WBPCreate sharedInstance] showWBProgress];
                       [networkingManagerTool requestToServerWithType:POST withSubUrl:kMobileBindWx withParameters:dataDict withResultBlock:^(BOOL result, id value) {
                           [[WBPCreate sharedInstance]hideAnimated];
                           if (result) {
                               self.wechatStateLabel.text = @"已绑定";
                               [userInfoModel sharedUser].weixin_unionid = user.uid;
                               NSLog(@"%@",user.uid);
                               SXF_HF_AlertView *alert =  [SXF_HF_AlertView showAlertType:(AlertType_exchnageSuccess) Complete:nil];
                               alert.title = @"绑定成功";
                               
                           }else {
                               if (value && [value isKindOfClass:[NSDictionary class]]) {
                                   [WXZTipView showCenterWithText:value[@"msg"]];
                               }else {
                                   [WXZTipView showCenterWithText:@"网络错误"];
                               }
                           }
                       }];
                   }else{
                       NSLog(@"error = %@",error);
                   }
               }];
    }

}

//支付宝
- (IBAction)tapAlipyCell:(UITapGestureRecognizer *)sender {
    
    if ([userInfoModel sharedUser].alipay_unionid) {
        //解绑
      SXF_HF_AlertView *aleart =  [SXF_HF_AlertView showAlertType:AlertType_binding_alipay Complete:^(BOOL btnBype) {
            if (btnBype) {
                
                [[WBPCreate sharedInstance]showWBProgress];
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"解绑支付宝" withParameters:nil withResultBlock:^(BOOL result, id value) {
                    [[WBPCreate sharedInstance]hideAnimated];
                    if (result) {
                        [userInfoModel sharedUser].alipay_unionid = nil;
                        SXF_HF_AlertView *alert =  [SXF_HF_AlertView showAlertType:(AlertType_exchnageSuccess) Complete:nil];
                        alert.title = @"解绑成功";
                        self.wechatStateLabel.text = @"未绑定";
                        
                    }else {
                        if (value && [value isKindOfClass:[NSDictionary class]]) {
                            [WXZTipView showCenterWithText:value[@"msg"]];
                        }else {
                            [WXZTipView showCenterWithText:@"网络错误"];
                        }
                    }
                }];
                
            }
        }];
    }
    else {
        //绑定
        [[WBPCreate sharedInstance] showWBProgress];
        NSString *appScheme = @"hanFuLife";//@"你的appScheme";
        //authStr参数后台获取！和开发中心配置的app有关系，包含appid\name等等信息。
        NSString *authStr = @"apiname=com.alipay.account.auth&app_id=xxxxx&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=xxxxx&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20141225xxxx&sign=fMcp4GtiM6rxSIeFnJCVePJKV43eXrUP86CQgiLhDHH2u%2FdN75eEvmywc2ulkm7qKRetkU9fbVZtJIqFdMJcJ9Yp%2BJI%2FF%2FpESafFR6rB2fRjiQQLGXvxmDGVMjPSxHxVtIqpZy5FDoKUSjQ2%2FILDKpu3%2F%2BtAtm2jRw1rUoMhgt0%3D";//@"后台获取的authStr";
        //没有安装支付宝客户端的跳到网页授权时会在这个方法里回调
        [[AFAuthSDK defaultService] authv2WithInfo:authStr fromScheme:appScheme callback:^(NSDictionary *result) {
            // 解析 auth code
            [[WBPCreate sharedInstance]hideAnimated];

            NSString *resultString = result[@"result"];
            NSString *authCode = nil;
            if (resultString.length>0) {
                NSArray *resultArr = [resultString componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            
//            if (state == SSDKResponseStateSuccess){
//
//                NSDictionary *dataDict = @{@"openid":user.uid,@"nickname":user.nickname,@"user_headimg":user.icon,@"sex":@(user.gender)};
//                [[WBPCreate sharedInstance] showWBProgress];
//                [[WBPCreate sharedInstance]showWBProgress];
//                [networkingManagerTool requestToServerWithType:POST withSubUrl:kMobileBindWx withParameters:dataDict withResultBlock:^(BOOL result, id value) {
//                    [[WBPCreate sharedInstance]hideAnimated];
//                    if (result) {
//                        self.wechatStateLabel.text = @"已绑定";
//                        [userInfoModel sharedUser].weixin_unionid = user.uid;
//                        SXF_HF_AlertView *alert =  [SXF_HF_AlertView showAlertType:(AlertType_exchnageSuccess) Complete:nil];
//                        alert.title = @"绑定成功";
//
//                    }else {
//                        if (value && [value isKindOfClass:[NSDictionary class]]) {
//                            [WXZTipView showCenterWithText:value[@"msg"]];
//                        }else {
//                            [WXZTipView showCenterWithText:@"网络错误"];
//                        }
//                    }
//                }];
//            }else{
//                NSLog(@"error = %@",error);
//            }
            
            NSLog(@"resultString = %@",resultString);
            NSLog(@"authv2WithInfo授权结果 authCode = %@", authCode?:@"");
        }];
        
    }
    
}

//手机号
- (IBAction)tapPhoneCell:(UITapGestureRecognizer *)sender {
    SXF_HF_exchangePhoneVc *exchangePhoneVC = [SXF_HF_exchangePhoneVc new];
    [self.navigationController pushViewController:exchangePhoneVC animated:YES];
}

@end
