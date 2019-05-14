//
//  ReviseMobilePhone.h
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReviseMobilePhone : BaseViewController
@property(nonatomic, copy) void (^setPhoneNumOk)(NSString *phoneNum);//s第三方登录设置手机号成功回调
@property (nonatomic,copy) NSString *tokenStr;//
@end

NS_ASSUME_NONNULL_END
