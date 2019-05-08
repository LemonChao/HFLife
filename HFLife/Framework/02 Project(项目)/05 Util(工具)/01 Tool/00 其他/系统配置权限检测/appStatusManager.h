//
//  appStatusManager.h
//  DuDuJR
//
//  Created by mini on 2018/1/26.
//  Copyright © 2018年 sxf. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

//判断相机全新头文件
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface appStatusManager : NSObject

/**
 判断是否开启定位
 */
+ (BOOL)isLocationServiceOpen;

/**
  判断是否允许消息通知
 */
+ (BOOL)isMessageNotificationServiceOpen;


/**
 跳转系统设置打开定位页面 , 相机 ， 相册 数据 都在一起
 */
+ (void)goSettingOpenLocation;

/**
 跳转系统设置打开消息页面
 */
+ (void)goSettingOpenMessage;


/**判断是否开启相册权限--ios8之前调用*/
+  (BOOL)checkPhotoStatus;

/**判断是否开启相册权限--ios8之后调用
    iOS 8 之后推荐用 #import <Photos/Photos.h> 中的判断
 */
+ (BOOL) checkPhotoStatus_After_ios8;

/*
 判断相册权限 --推荐使用
 **/
+ (BOOL)isCanUsePhotos;

/*
 判断相机权限
 **/
+ (BOOL)isCanUseCamare;

/**
 跳转到相册 ,相机 设置
 */
+ (void)goSettingOpenPhoto;
@end
