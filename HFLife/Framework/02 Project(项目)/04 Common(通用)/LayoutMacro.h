//
//  LayoutMacro.h
//  LiveTest
//
//  Created by mac on 2018/1/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef LayoutMacro_h
#define LayoutMacro_h

//颜色的宏
#define SUBJECTCOLOR  [UIColor blackColor]
//程序名
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


/**
 *判断是否是iPhoneX及以上版本
 */
#define IPHONE_X_Later \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/**
 *导航栏高度
 */
#define SafeAreaTopHeight (IPHONE_X_Later ? 88 : 64)

/**
 *tabbar高度
 */
#define SafeAreaTabBarHeight (IPHONE_X_Later ? (49 + 34) : 49)
/**
 *底部安全区域高度
 */
#define SafeAreaBottomHeight (IPHONE_X_Later ? (34) : 0)




/** 获取mainScreen的bounds */
#define MMScreenBounds [[UIScreen mainScreen] bounds]

/** 屏幕宽度 */
#define SCREEN_WIDTH    MMScreenBounds.size.width

/** 屏幕高度 */
#define SCREEN_HEIGHT   MMScreenBounds.size.height

//是否是iPhone X系列
#define iPhoneX (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)

/** 获取适合屏幕的宽度 （x 宽度值(UI设计图上标注的) 注意： PX标注记得X2 ）*/
#define WidthRatio(x)     (iPhoneX ? x/2 :x /750.0 * SCREEN_WIDTH )

/** 获取适合屏幕的高度值 （x 高度值(UI设计图上标注的) 注意： PX标注记得X2）*/
#define HeightRatio(x)    (iPhoneX ? x/2 :x /1334.0 * SCREEN_HEIGHT )

/// 字体大小调整系数 适应屏幕的宽度 x
#define FontRatio(x)     (x /375.0 * SCREEN_WIDTH)

#define Height_NavContentBar 44.0f

/** 状态栏高度 */
#define HeightStatus (iPhoneX ? 44.0 : 20.0)

/** 导航栏高度 */
#define NavBarHeight (iPhoneX ? 88.0 : 64.0)

/** TabBar高度 */
#define TabBarHeight (iPhoneX ? 83.0 : 49.0)

//没有Tabar底部距离宏
#define HJBottomHeight (iPhoneX ? 34 : 0)

#endif /* LayoutMacro_h */
