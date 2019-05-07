//
//  JQThirdLoginUserManager.m
//  JiuQu
//
//  Created by kk on 2017/5/2.
//  Copyright © 2017年 JiuQuBuy. All rights reserved.
//

#import "JQThirdLoginUserManager.h"


@interface JQThirdLoginUserManager()



@end


static JQThirdLoginUserManager *thirdLoginManager = nil;
@implementation JQThirdLoginUserManager

#pragma mark -init
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thirdLoginManager = [[JQThirdLoginUserManager alloc]init];
    });
    return thirdLoginManager;
}


/*
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType currentVC:(UIViewController *)currentVC AutoSuccess:(authorizationSuccess)success AutoFail:(authorizationFail)fail 
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:currentVC completion:^(id result, NSError *error) {
        
        NSLog(@"获取第三方全部信息是%@",result);
        
        
        if (error) {
            NSLog(@"授权错误%@",error);
            fail(error);
        }else{
            
           UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
           success(resp);
        }
    }];
}

*/


@end
