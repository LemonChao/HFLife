//
//  LoginVC.h
//  HanPay
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : BaseViewController

/**
 是否是Present进来的
 */
@property (nonatomic,assign)BOOL isPresent;
/** 跳转登录 */
+ (void)login;
/** 切换到首页 */
+ (void)changeIndxHome;
/** 获取支付宝 authCode*/
+ (void)aliPayInfo:(void (^)(NSString *authCode))authInfo;
@end

NS_ASSUME_NONNULL_END
