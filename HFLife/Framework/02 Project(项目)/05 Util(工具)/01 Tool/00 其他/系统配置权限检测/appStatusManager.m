
//
//  appStatusManager.m
//  DuDuJR
//
//  Created by mini on 2018/1/26.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import "appStatusManager.h"

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@implementation appStatusManager


+ (BOOL)isLocationServiceOpen {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

+ (BOOL)isMessageNotificationServiceOpen {
    if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
        return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    } else {
        return UIRemoteNotificationTypeNone != [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
}

+ (void)goSettingOpenLocation{
    if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    }
}


+ (void)goSettingOpenMessage{
    if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"]];
    }
}




/*
 typedef enum {
 kCLAuthorizationStatusNotDetermined = 0, // 用户尚未做出选择这个应用程序的问候
 kCLAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
 kCLAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
 kCLAuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据
 } CLAuthorizationStatus;
 链接：https://www.jianshu.com/p/2e01fa3fefe8
 **/
+  (BOOL)checkPhotoStatus{//ios8之前调用
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied)
    {
        //无权限
        return NO;
    }
    return YES;
}

+ (BOOL) checkPhotoStatus_After_ios8{//推荐用
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}


+ (BOOL)isCanUsePhotos {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
        if (status == PHAuthorizationStatusNotDetermined) {
            
        }
        if (status == PHAuthorizationStatusRestricted) {
            
        }
        if (status == PHAuthorizationStatusDenied) {
            
        }
        if (status == PHAuthorizationStatusAuthorized) {
           
        }
        
//        if (status == PHAuthorizationStatusRestricted ||
//            status == PHAuthorizationStatusDenied || PHAuthorizationStatusNotDetermined) {
//            //无权限
//            return NO;
//        }
    }
    return YES;
}


/**
 typedef NS_ENUM(NSInteger, AVAuthorizationStatus) {
 AVAuthorizationStatusNotDetermined = 0,// 系统还未知是否访问，第一次开启相机时
 AVAuthorizationStatusRestricted, // 受限制的
 AVAuthorizationStatusDenied, //不允许
 AVAuthorizationStatusAuthorized // 允许状态
 } NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
 */
+ (BOOL)isCanUseCamare{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        return NO;
    }
    return YES;
}

/**跳转到相册设置*/
+ (void)goSettingOpenPhoto{
    // 系统是否大于10
    NSURL *url = nil;
    if ([[UIDevice currentDevice] systemVersion].floatValue < 10.0) {
        url = [NSURL URLWithString:@"prefs:root=privacy"];
        
    } else {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    }
    [[UIApplication sharedApplication] openURL:url];
    

   //www.jianshu.com/p/c1da460d7e11

}


@end
