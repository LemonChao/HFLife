

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HRSettingItem) {
    HRSettingsHome,             //设置
    HRSettingsAirPlane,         //飞行模式
    HRSettingsWifi,             //Wifi
    HRSettingsBluetooth,        //蓝牙
    HRSettingsHotSpot,          //个人热点
    HRSettingsNotification,     //通知
    HRSettingsGeneral,          //通用
    HRSettingsGeneralAbout,     //通用／关于本机
    HRSettingsLocationService,  //隐私／定位服务
    HRSettingsPhone,            //电话
};

@interface HRURLScheme : NSObject

//访问设置页面或子页面
//访问系统app（含系统设置界面等）
+ (void)openSystemApp:(NSString *)urlScheme;
//访问其他app
+ (void)openOtherApp:(NSString *)urlScheme;

@end
