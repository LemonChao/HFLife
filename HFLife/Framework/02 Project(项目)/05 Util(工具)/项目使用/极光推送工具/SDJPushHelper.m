//
//  SDJPushHelper.m
//  SDFastSendUser
//
//  Created by mac on 2017/6/28.
//  Copyright © 2017年 SDJS. All rights reserved.
//

#import "SDJPushHelper.h"

@implementation SDJPushHelper
+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction
  advertisingIdentifier:(NSString *)advertisingId
               delegate:(id<JPUSHRegisterDelegate>)delegate{
        // 3.0.0及以后版本注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];
    [JPUSHService registerLbsGeofenceDelegate:delegate withLaunchOptions:launchingOption];
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONEisProduction_7_1
//   
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        
//        
//        
//    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 )  {
//         // ios8之后可以自定义category
//        // 可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
//        // ios8之前 categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//#endif
//    }
//#else
//    // categories 必须为nil
//    [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                      UIRemoteNotificationTypeSound |
//                                                      UIRemoteNotificationTypeAlert)
//                                          categories:nil];
//#endif
    
    [JPUSHService setupWithOption:launchingOption appKey:appKey channel:channel apsForProduction:isProduction advertisingIdentifier:advertisingId];
    
    return;
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    return;
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion {
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (completion) {
        completion(UIBackgroundFetchResultNewData);
    }
    return;
}

+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    return;
}
@end
