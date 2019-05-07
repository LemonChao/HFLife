
    //
    //  AppDelegate+JPush.m
    //  QQRunning
    //
    //  Created by mac on 2017/9/18.
    //  Copyright © 2017年 软盟. All rights reserved.
    //

#import "AppDelegate+JPush.h"
#import "NSString+Helper.h"
#import <Foundation/Foundation.h>
    //#import "LocalNotificationPush.h"
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>

static NSMutableArray *OrderArray;
static NSString *broadcastOrderID;
static NSMutableArray *OrderIdArray;
@implementation AppDelegate (JPush)

-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions delegate:(id<JPUSHRegisterDelegate>)delegate{
    BOOL isProduction = NO;
#ifdef DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    [SDJPushHelper setupWithOption:launchOptions appKey:kJPAppKey channel:@"App Store" apsForProduction:isProduction advertisingIdentifier:nil delegate:delegate];
        //JPush 监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
    OrderArray = [NSMutableArray array];
    OrderIdArray = [NSMutableArray array];
    
//    //获取自定义消息推送内容
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
        // Required - 注册 DeviceToken
    [SDJPushHelper registerDeviceToken:deviceToken];
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)(void))completionHandler {
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)(void))completionHandler {
    
}
#endif


/**
 收到推送
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
        // Required,For systems with less than or equal to iOS6
    [SDJPushHelper handleRemoteNotification:userInfo completion:nil];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
}
/**
 当开启了极光推送的代理的话，那么将不走这个方法，但是如果应用处于前台的话，那么不管是否开启代理都会走这个方法
 **/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
        //    [self billCountDown];
    NSDictionary *extras = userInfo[@"extras"];
    if (extras != nil) {
        
    }else{
        NSString * type    = [NSString stringWithFormat:@"%@",userInfo[@"type"]];
        if (![type isEqualToString:@"0"]) {
            [self receive:userInfo];
        }
        
    }
    
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    [SDJPushHelper handleRemoteNotification:userInfo completion:completionHandler];
}
/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
        //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [SDJPushHelper showLocalNotificationAtFront:notification];
    return;
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate 极光推送代理
/**
 * 当开启了极光推送的代理，在处于应用程序内部收到的推送将会执行这个方法
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
        // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if (@available(iOS 10.0, *)) {
//        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//            [JPUSHService handleRemoteNotification:userInfo];
//        }
//    } else {
//            // Fallback on earlier versions
//    }
//    if (@available(iOS 10.0, *)) {
//        completionHandler(UNNotificationPresentationOptionAlert);
//    } else {
//            // Fallback on earlier versions
//    } // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
    }
    else {
            // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

/**
 * 当开启了极光推送的代理，在处于应用程序外部点击通知进入程序内部将会执行这个方法
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
        //   response.n
        // Required
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    NSDictionary *extras = userInfo[@"extras"];
//
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//        [self reinstallBadge];
//    }
//    if (extras != nil) {
//
//    }else{
//        [self receive:userInfo];
//    }
//    completionHandler();  // 系统要求执行这个方法
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
    }
    else {
            // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    NSString *title = nil;
    if (notification) {
        title = @"从通知界面直接进入应用";
    }else{
        title = @"从系统设置界面进入应用";
    }
    UIAlertView *test = [[UIAlertView alloc] initWithTitle:title
                                                   message:@"pushSetting"
                                                  delegate:self
                                         cancelButtonTitle:@"yes"
                                         otherButtonTitles:nil, nil];
    [test show];
    
}
#endif

#pragma mark----自定义消息--------
//获取自定义消息推送内容
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSLog(@"messagetime1111111111111");
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *extras = userInfo[@"extras"];
    NSLog(@"extras= %@",extras);
    
    
}
/**
 *  登录成功，设置别名，移除监听
 *
 *  @param notification 通知对象
 */
- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    [JPUSHService crashLogON];
    if (![NSString isNOTNull:[UserCache getUserId]]) {
        NSString *bieMing = [NSString stringWithFormat:@"HL_%@",[UserCache getUserId]];
        NSLog(@"设置的别名 %@",bieMing);
        [JPUSHService setAlias:bieMing completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            NSLog(@"rescode: %ld, \nseq: %ld, \nalias: %@\n", (long)iResCode, (long)seq , iAlias);
        } seq:0];
    }
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
            //NSLog(@"registrationID = %@",registrationID);
        [[NSUserDefaults standardUserDefaults] setValue:registrationID forKey:@"registID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kJPFNetworkDidLoginNotification
                                                  object:nil];
    
}
#pragma mark -- 处理推送
-(void)dealWithTheNotification:(NSDictionary *)userInfo{
    
    
    
}
//处理推送消息
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
#pragma mark--自定义语音播报
- (void)PlayVoiceTitle:(NSString *)title isDelegate:(BOOL)isDelegate
{
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:title];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置语言
    utterance.voice = voice;
        //    NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    utterance.volume= 1;  //设置音量（0.0~1.0）默认为1.0
    utterance.rate= AVSpeechUtteranceDefaultSpeechRate;  //设置语速
    utterance.pitchMultiplier= 1;  //设置语调
    
        //读完一段后的停顿时间
    utterance.postUtteranceDelay = 0.1;
        //读一段话之前的停顿
    utterance.preUtteranceDelay = 0.2;
    
    synth = [[AVSpeechSynthesizer alloc] init];
    if (isDelegate) {
        synth.delegate = self;
    }
    
    [synth speakUtterance:utterance];
    
    
}
-(void)reinstallBadge{
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
    //程序外部
-(BOOL) runningInBackground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateBackground);
    
    return result;
}
    //程序内部
-(BOOL) runningInForeground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateActive);
    
    return result;
}
#pragma mark-----四舍五入
- (NSString *)DecimalNumber:(float)distance
{
    
    NSString *distanceStr = [NSString stringWithFormat:@"%f",distance];
    NSDecimalNumberHandler *roundBankers = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithString:distanceStr];
    NSDecimalNumber *b = [NSDecimalNumber decimalNumberWithString:@"1000"];
        // 除
    NSDecimalNumber *divide = [a decimalNumberByDividingBy:b withBehavior:roundBankers];
    return [NSString stringWithFormat:@"%@",divide];
    
}
@end
