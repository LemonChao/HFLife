//
//  SetingMobilePhoneVC.h
//  HFLife
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypeWeiXin,//默认从0开始
    LoginTypeAliPay,
};

@interface SetingMobilePhoneVC : BaseViewController
@property(nonatomic, copy) void (^setPhoneNumOk)(NSString *phoneNum);//s第三方登录设置手机号成功回调
@property (nonatomic,copy) NSString *openIdStr;//
@property(nonatomic, assign) LoginType loginType;//
@end

NS_ASSUME_NONNULL_END
