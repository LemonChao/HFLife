//
//  SXF_HF_LoginAlertView.h
//  mytest
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HF_AlertType) {
    AlertType_login,//登录提示
    AlertType_save,//安全提示,
    AlertType_Pay,//支付提示
    AlertType_time,//时间选择
    AlertType_topRight,//右上角选择弹窗
    AlertType_binding,//解绑弹窗
    AlertType_binding_alipay,//解绑支付宝弹窗
    AlertType_exchnageSuccess,//更换成功！
    AlertType_exchnage,//一月更新一次
    AlertType_realyCheck,//实名认证
    AlertType_cancellation,//注销
};


NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_AlertView : UIView
@property (nonatomic, assign)HF_AlertType alertType;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *msg;


/**
 app弹窗封装

 @param alertType <#alertType description#>
 @param complate <#complate description#>
 */
+ (SXF_HF_AlertView *) showAlertType:(HF_AlertType) alertType Complete:(void(^__nullable)(BOOL btnBype))complate;


/**
 时间选择

 @param complate <#complate description#>
 */
+ (void) showTimeSlecterAlertComplete:(void(^__nullable)(NSString *year, NSString *month))complate;

@end

NS_ASSUME_NONNULL_END
