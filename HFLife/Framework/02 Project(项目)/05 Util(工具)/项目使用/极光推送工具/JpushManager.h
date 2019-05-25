//
//  JpushManager.h
//  DeliveryOrder
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JPUSHService.h>
#import <AdSupport/AdSupport.h>
//ios12系统特性
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
NS_ASSUME_NONNULL_BEGIN
static NSString *Jpush_Registration_Id   =   @"jpush_registration_id";
@interface JpushManager : NSObject
+(instancetype)sharedManager;

/**
 注册
 */
-(void) registNotification :(id)delegate  options:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
