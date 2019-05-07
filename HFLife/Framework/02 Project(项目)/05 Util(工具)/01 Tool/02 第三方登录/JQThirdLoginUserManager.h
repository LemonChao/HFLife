//
//  JQThirdLoginUserManager.h
//  JiuQu
//
//  Created by kk on 2017/5/2.
//  Copyright © 2017年 JiuQuBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^authorizationFail)(NSError *error);
typedef void(^authorizationSuccess)(id result);

@interface JQThirdLoginUserManager : NSObject

@property (nonatomic,copy) authorizationFail    failAuto;
@property (nonatomic,copy) authorizationSuccess autoSuccess;




/**
 初始化方法

 @return 实例对象
 */
+(instancetype)shareInstance;



/**
 授权获取用户信息

 @param platformType 平台类型
 @param currentVC 当前所在控制器
 @param fail 授权失败回调
 @param success 授权成功的回调
 */

//
//- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType currentVC:(UIViewController *)currentVC AutoSuccess:(authorizationSuccess)success AutoFail:(authorizationFail)fail;


@end
