//
//  LoginForVercode.h
//  HFLife
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//  手机验证码登录

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginForVercode : BaseViewController
/**
 换个新账号，带返回
 */
@property (nonatomic,assign)BOOL isChangeNewAccount;
/**
 是否是Present进来的
 */
@property (nonatomic,assign)BOOL isPresent;
@end

NS_ASSUME_NONNULL_END
