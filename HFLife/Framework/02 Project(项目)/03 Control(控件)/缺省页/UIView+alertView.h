//
//  UIView+alertView.h
//  DoLifeApp
//
//  Created by sxf_pro on 2018/7/13.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "errorAlertViewViewController.h"
#import "alertView.h"
@interface UIView (alertView)

/**添加到view*/
- (void)showAlertViewToViewImageTYpe:(alertView_type)alertType//图片类型
                                 msg:(NSString *)msg//提示
                             forView:(view_type)isView//添加到view的类型
                         imageCenter:(CGFloat)centerY//图片中心点高度 0为默认高度
                          errorBlock:(void(^)(void))errorBlock;//点击回调
//添加到view/windown
//- (void)showAlertViewToViewImageTYpe:(alert_type)alertType msg:(NSString *)msg forView:(view_type)isView control:(UIViewController *)vc errorBlock:(void(^)(void))errorBlock;

//移除
- (void) removeAlertView;

@end
