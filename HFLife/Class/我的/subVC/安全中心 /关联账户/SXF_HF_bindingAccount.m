
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
    self.wechatStateLabel.text = [NSString judgeNullReturnString:[userInfoModel sharedUser].weixin_unionid].length > 0 ? @"已绑定":@"未绑定";
    self.alipayStateLabel.text = [NSString judgeNullReturnString:[userInfoModel sharedUser].alipay_unionid].length > 0 ? @"已绑定":@"未绑定";
    self.phoneNumLabel.text = [[userInfoModel sharedUser].member_mobile EncodeTel];
    
}


//微信
- (IBAction)tapWechatCell:(UITapGestureRecognizer *)sender {
    
    if ([NSString judgeNullReturnString:[userInfoModel sharedUser].weixin_unionid].length > 0) {
        //解绑
        [SXF_HF_AlertView showAlertType:AlertType_binding Complete:^(BOOL btnBype) {
            if (btnBype) {
                
                [[WBPCreate sharedInstance]showWBProgress];
                [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kMobileRemoveWx) withParameters:nil withResultBlock:^(BOOL result, id value) {
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
                       [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kMobileBindWx) withParameters:dataDict withResultBlock:^(BOOL result, id value) {
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
      [SXF_HF_AlertView showAlertType:AlertType_binding_alipay Complete:^(BOOL btnBype) {
            if (btnBype) {
                [[WBPCreate sharedInstance]showWBProgress];
                [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kMobileRemoveAlipay) withParameters:nil withResultBlock:^(BOOL result, id value) {
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
        
        [LoginVC aliPayInfo:^(NSString * _Nonnull authCode) {
            
            NSDictionary *dataDict = @{@"auth_code":authCode};
            [[WBPCreate sharedInstance] showWBProgress];
            [[WBPCreate sharedInstance]showWBProgress];
            [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kMobileBindAlipay) withParameters:dataDict withResultBlock:^(BOOL result, id value) {
                [[WBPCreate sharedInstance]hideAnimated];
                if (result) {
                    self.wechatStateLabel.text = @"已绑定";
                    [userInfoModel getUserInfo];
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
        }];
    }
    
}

//手机号
- (IBAction)tapPhoneCell:(UITapGestureRecognizer *)sender {
    SXF_HF_exchangePhoneVc *exchangePhoneVC = [SXF_HF_exchangePhoneVc new];
    [self.navigationController pushViewController:exchangePhoneVC animated:YES];
}

@end
