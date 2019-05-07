

#import "HRURLScheme.h"
#import <UIKit/UIKit.h>

@implementation HRURLScheme

//访问设置页面或子页面
+ (void)openSettingItem:(HRSettingItem)item {
    NSString *url = @"";
    switch (item) {
        case HRSettingsHome:
            url = @"prefs:root=SETTING";
            break;
        case HRSettingsAirPlane:
            url = @"prefs:root=AIRPLANE_MODE";
            break;
        case HRSettingsWifi:
            url = @"prefs:root=WIFI";
            break;
        case HRSettingsBluetooth:
            url = @"prefs:root=Bluetooth";
            break;
        case HRSettingsHotSpot:
            url = @"prefs:root=INTERNET_TETHERING";
            break;
        case HRSettingsNotification:
            url = @"prefs:root=NOTIFICATIONS_ID";
            break;
        case HRSettingsGeneral:
            url = @"prefs:root=General";
            break;
        case HRSettingsGeneralAbout:
            url = @"prefs:root=General&path=About";
            break;
        case HRSettingsPhone:
            url = @"prefs:root=Phone";
            break;
        case HRSettingsLocationService:
            url = @"prefs:root=LOCATION_SERVICES";
            break;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    } else {
        NSLog(@"\"%@\"-URL无法访问", url);
    }
}
//访问系统app（含系统设置界面等）
+ (void)openSystemApp:(NSString *)urlScheme {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlScheme]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlScheme] options:@{} completionHandler:nil];
    } else {
        NSLog(@"\"%@\"-URL无法访问", urlScheme);
    }
}
//访问其他app
+ (void)openOtherApp:(NSString *)urlScheme {
    NSString *urlStr = [NSString stringWithFormat:@"%@://", urlScheme];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
    } else {
        NSLog(@"\"%@\"-URL无法访问", urlScheme);
    }
}

@end

/*
 关于本机	prefs:root=General&path=About
 辅助功能	prefs:root=General&path=ACCESSIBILITY
 飞行模式	prefs:root=AIRPLANE_MODE
 自动锁定	prefs:root=General&path=AUTOLOCK
 蓝牙	prefs:root=Bluetooth
 日期与时间	prefs:root=General&path=DATE_AND_TIME
 FaceTime	prefs:root=FACETIME
 通用	prefs:root=General
 键盘	prefs:root=General&path=Keyboard
 iCloud	prefs:root=CASTLE
 iCloud存储空间	prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 语言与地区	prefs:root=General&path=INTERNATIONAL
 定位服务	prefs:root=LOCATION_SERVICES
 邮件、通讯录、日历	prefs:root=ACCOUNT_SETTINGS
 音乐	prefs:root=MUSIC
 音乐	prefs:root=MUSIC&path=EQ
 音乐	prefs:root=MUSIC&path=VolumeLimit
 备忘录	prefs:root=NOTES
 通知	prefs:root=NOTIFICATIONS_ID
 电话	prefs:root=Phone
 照片与相机	prefs:root=Photos
 描述文件	prefs:root=General&path=ManagedConfigurationList
 还原	prefs:root=General&path=Reset
 电话铃声	prefs:root=Sounds&path=Ringtone
 Safari	prefs:root=Safari
 声音	prefs:root=Sounds
 软件更新	prefs:root=General&path=SOFTWARE_UPDATE_LINK
 App Store	prefs:root=STORE
 Twitter	prefs:root=TWITTER
 视频	prefs:root=VIDEO
 VPN	prefs:root=General&path=VPN
 墙纸	prefs:root=Wallpaper
 WiFi	prefs:root=WIFI
 个人热点	prefs:root=INTERNET_TETHERING
 */






