
//
//  JpushManager.m
//  DeliveryOrder
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import "JpushManager.h"


//极光推送
#define Jpush_appKey  @"dd02ac06ccca0975d7ec3bb4"
#define Jpush_appSecret @"3c6fca7cf0b7d67b2445e939"//没用


@interface JpushManager ()<JPUSHRegisterDelegate, UIApplicationDelegate>
@property (nonatomic ,strong) NSDictionary *launchOptions;
@end

@implementation JpushManager

static JpushManager *manager = nil;

+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[JpushManager alloc] init];
        }
    });
    return manager;
}

-(void) registNotification :(id)delegate  options:(NSDictionary *)launchOptions{
    self.launchOptions = launchOptions;
    
    if (launchOptions) {
        //获取杀死后的通知消息 如果不为nil就可以获取到
        
        //字典转字符串 用于测试
        NSData *data = [NSJSONSerialization dataWithJSONObject:launchOptions options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        [CustomPromptBox showTextHud:[NSString stringWithFormat:@"杀死后  %@", str]];
    }
    
    
    //    1.添加初始化APNs代码
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //获取registrationID
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
        //存储
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:Jpush_Registration_Id];
        
        
        
        
        
    }];
    

    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //    2.添加初始化JPush代码
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//        NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
#if DEBUG
    [JPUSHService setupWithOption:launchOptions appKey:Jpush_appKey
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:nil];
#else
    [JPUSHService setupWithOption:launchOptions appKey:Jpush_appKey
                          channel:@"App Store"
                 apsForProduction:1
            advertisingIdentifier:nil];
#endif
    //处理apnsc的消息
    [JPUSHService handleRemoteNotification:launchOptions];
    
    //自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}
//实现回调方法 networkDidReceiveMessage 自定义消息回调
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    
    
    
    
    NSString *content = [userInfo valueForKey:@"content"];
    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的 Extras 附加字段，key 是自己定义的
    NSURL *sourceUrl = [[NSBundle mainBundle] URLForResource:@"sourceSound" withExtension:@"caf"];
    //    //组装并播放音效
    SystemSoundID soundID;
    //    NSURL *filePath = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)sourceUrl, &soundID);
    AudioServicesPlayAlertSound(soundID);
    
    [CustomPromptBox showTextHud:[NSString stringWithFormat:@"我是自定义消息  %@", content]];
}
//如果delegate 设置为当前类 那么 可在这里注册

//推送回调代理 (非自定义消息状态下)


//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//
//
//    //是否处于前台
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {
//        NSLog(@"应用程序在前台");
//        completionHandler(UNNotificationPresentationOptionAlert);
//    }else{
//        completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//    }
//}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    
    
    [CustomPromptBox showTextHud:[NSString stringWithFormat:@"%s", __func__]];
    
    //点击窗口进来
    NSLog(@"收到通知 内容 ：------%@", response.notification.request.content.body);
    completionHandler();  //系统要求执行这个方法
}




// NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")



// iOS 10 Support,程序在前台时

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger)
                                                                                                                                                 
                                                                                                                                                 )completionHandler {
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    
    
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]
            
            ]) {
            
            //判断是新订单还是退货
            
            NSString *str =[NSString stringWithFormat:@"%@",userInfo[@"aps"][@"alert"]];
            
            NSLog(@"user-----%@",userInfo);
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"sourceSound" ofType:@"caf"];
            
            //这里是指你的音乐名字和文件类型
            NSLog(@"path---%@",path);
            
            //组装并播放音效
            SystemSoundID soundID;
            
            NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
            
            AudioServicesPlaySystemSound(soundID);
            if ([str containsString:@"新订单"]) {
                //音效文件路径
                NSString *path = [[NSBundle mainBundle] pathForResource:@"sourceSound" ofType:@"caf"];
                
//                这里是指你的音乐名字和文件类型
                
                NSLog(@"path---%@",path);
                
                //组装并播放音效
                
                SystemSoundID soundID;
                
                NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
                
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
                
                AudioServicesPlaySystemSound(soundID);
                
            }else if([str containsString:@"退货"]){
                
                
                
            }else{
                
                
                
            }
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执 这个 法，选择 是否提醒 户，有Badge、Sound、Alert三种类型可以选择设置
    
}



//
//iOS 7 Remote Notification


#pragma mark- JPUSHRegisterDelegate // 2.1.9 版新增JPUSHRegisterDelegate,需实现以下两个方法









#pragma mark- JPUSHRegisterDelegate

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate

//前台
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
//    NSDictionary * userInfo = notification.request.content.userInfo;
//
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    sound = [UNNotificationSound soundNamed:@"sourceSound"];
//
//
//
//
//
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
//        NSLog(@"%@",body );
//
////        [rootViewController addNotificationCount];
//
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//}


#endif

#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    NSString *title = nil;
    [CustomPromptBox showTextHud:@"什么时候进来"];
    [CustomPromptBox showTextHud:[NSString stringWithFormat:@"%s", __func__]];
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


// log NSSet with UTF8
// if not ,log will be \Uxxx
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


@end
