//
//  AppDelegate.m
//  HFLife
//
//  Created by mac on 2018/12/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "customTabBarViewController.h"
#import "NetWorkHelper.h"
#import "ZAlertViewManager.h"
#import "BaseNavigationController.h"
#import "LoginVC.h"

#import "ViewController.h"

#import "UMSPPPayUnifyPayPlugin.h"
#import "UMSPPPayPluginSettings.h"
//极光统计
#import "JANALYTICSService.h"

#import "LYBmOcrManager.h"
#import "AppDelegate+JAnalytics.h"
#import "JpushManager.h"
@interface AppDelegate ()
@property(nonatomic,strong)UITabBarController *tabbar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self monitoringNetwork];
    [self initWithKeyboard];
    [self changeRootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self initWithKeyboard];
    [self configNotification:launchOptions];
    //设置APIKEY
    [AMapServices sharedServices].apiKey = MAP_KEY;
    [AMapServices sharedServices].enableHTTPS = YES;
    //银联生产环境
    [UMSPPPayPluginSettings sharedInstance].umspEnviroment = UMSP_PROD;
    //不设置调起银联的启动页
    [UMSPPPayPluginSettings sharedInstance].umspSplash = NO;
    //调起支付使用
    [UMSPPPayUnifyPayPlugin registerApp:WX_APP_ID];
    // 极光统计
    [self JAnalyticsApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    //百度Acr
    [[LYBmOcrManager ocrShareManaer] configOcr];
    //share
    [self registerShare];
    
    
    
    return YES;
}
-(void)registerShare{
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
        [platformsRegister setupQQWithAppId:QQ_APP_ID appkey:QQ_APP_SECRET];
        
        //微信
        [platformsRegister setupWeChatWithAppId:WX_APP_ID appSecret:WX_APP_SECRET];
    }];
    //    @(SSDKPlatformTypeSinaWeibo),//新浪微博
    /**
     [ShareSDK registerActivePlatforms:@[
     @(SSDKPlatformTypeUnknown),
     @(SSDKPlatformSubTypeWechatSession),
     @(SSDKPlatformSubTypeWechatTimeline),
     @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
     switch (platformType)
     {
     case SSDKPlatformTypeWechat:
     [ShareSDKConnector connectWeChat:[WXApi class]];
     break;
     case SSDKPlatformTypeQQ:
     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
     break;
     default:
     break;
     }
     } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
     switch (platformType)
     {
     //                                                case SSDKPlatformTypeSinaWeibo:
     //
     //                                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
     //                                                    [appInfo SSDKSetupSinaWeiboByAppKey:@"1028008656"
     //                                                                              appSecret:@"b035fd31098fa8803d984d3325b5cbc8"
     //                                                                            redirectUri:@"http://sns.whalecloud.com/sina2/callback"
     //                                                                               authType:SSDKAuthTypeBoth];
     //                                                    break;
     case SSDKPlatformTypeTencentWeibo:
     
     //设置腾讯微博应用信息
     [appInfo SSDKSetupTencentWeiboByAppKey:QQ_APP_WB_ID
     appSecret:QQ_APP_WB_SECRET
     redirectUri:@"http://www.sharesdk.cn"];
     break;
     //                                                case SSDKPlatformTypeFacebook:
     //
     //                                                    //设置Facebook应用信息，其中authType设置为只用Web形式授权
     //                                                    [appInfo SSDKSetupFacebookByApiKey:@"107704292745179"
     //                                                                             appSecret:@"38053202e1a5fe26c80c753071f0b573"
     //                                                                              authType:SSDKAuthTypeWeb];
     //                                                    break;
     //                                                case SSDKPlatformTypeTwitter:
     //
     //                                                    //设置Twitter应用信息
     //                                                    [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
     //                                                                            consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
     //                                                                               redirectUri:@"http://mob.com"];
     //                                                    break;
     case SSDKPlatformTypeWechat:
     
     //设置微信应用信息
     [appInfo SSDKSetupWeChatByAppId:WX_APP_ID
     appSecret:WX_APP_SECRET];
     
     break;
     case SSDKPlatformTypeQQ:
     
     //设置QQ应用信息，其中authType设置为只用SSO形式授权
     [appInfo SSDKSetupQQByAppId:QQ_APP_ID
     appKey:QQ_APP_SECRET
     authType:SSDKAuthTypeSSO];
     break;
     default:
     break;
     }
     }];
     */
}

- (void)configNotification: (NSDictionary *)launchOptions{
    [[JpushManager sharedManager] registNotification:self options:launchOptions];
}
#pragma mark 监测网络
-(void)monitoringNetwork{
    [NetWorkHelper networkStatusWithBlock:^(NetWorkStatusType status) {
        if (status == NetworkStatusNotReachable) {
            [[ZAlertViewManager shareManager] showWithType:3 title:@"暂无网络，请查看设置"];
            [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
                //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=Network"]];
            }];
            [[ZAlertViewManager shareManager] dismissAlertWithTime:5];
        }
//        NSNotification *notification =[NSNotification notificationWithName:NETWORK_CHANGES object:nil userInfo:nil];
        // 3.通过 通知中心 发送 通知
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }];
}
#pragma mark ————— 键盘处理 —————
-(void)initWithKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    //    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}


#pragma mark ————— 设置主视图 —————
-(void)changeRootViewController{
    UITabBarController *tabBar = [customTabBarViewController configerTableBarVC];
    tabBar.navigationController.navigationBarHidden = YES;
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
}
-(void)changLoginRootViewController{
    [[self topViewController].navigationController pushViewController:[[LoginVC alloc]init] animated:YES];
}

//退出登录
-(void)LogOut:(NSNotification *)noti{
    //    [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
    //                NSLog(@"设置结果:%i 用户别名",iResCode);
    //    }];
    [JPUSHService setTags:nil completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0];
    //清除用户相关信息
//    [UserCache valueEmpty];
//    [UserCache UserPassEmpty];
    [HeaderToken valueEmpty];
}
-(void)RefreshTokeNotification:(NSNotification *)noti{
    //清除用户相关信息
//    [UserCache valueEmpty];
//    [UserCache UserPassEmpty];
    [HeaderToken valueEmpty];
    if ([[self topViewController] isKindOfClass:[LoginVC class]]) {
        return ;
    }
    
//    [self changLoginRootViewController];
    //    LoginVC *login = [[LoginVC alloc]init];
    //    login.isPresent = YES;
    //    BaseNavigationController *nav =[[BaseNavigationController alloc]initWithRootViewController:login];
    //    [self.tabbar presentViewController:nav animated:YES completion:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"不活跃");
    //持久书 个人信息
    
    
    //写入到沙盒
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [array.firstObject stringByAppendingPathComponent:@"userInfo"];
    
    userInfoModel *user = [userInfoModel sharedUser];
    
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
    
    [self archiver];
}

//按Home键使App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

//点击App图标，使App从后台恢复至前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    
    NSLog(@"进入前台");
    //通知轮询订单 支付宝 /微信
    [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil userInfo:@{@"status" : @(1)}];
    
    
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //读取用户信息
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [array.firstObject stringByAppendingPathComponent:@"userInfo"];
    
//    userInfoModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
//    NSLog(@"user ==  %@", user);
    
    NSLog(@"开始活跃");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    
    NSString *string =[url absoluteString];
    if ([string hasPrefix:@"unifyPayHanPay://"])
    {
        return [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }
    return  [UMSPPPayUnifyPayPlugin handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSString *string =[url absoluteString];
    if ([string hasPrefix:@"unifyPayHanPay://"])
    {
        return [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }
    
    return [UMSPPPayUnifyPayPlugin handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options{
    
    
   
    NSString *string =[url absoluteString];
    
    if ([string hasPrefix:@"hanFuLife"]) {
        //授权返回码
        [[AFAuthSDK defaultService]processAuthv2Result:url standbyCallback:^(NSDictionary *result) {
            if (result) {
                
            }
        }];
        return YES;
    }
    
    if ([string hasPrefix:@"unifyPayHanPay://"])
    {
        return [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }
    
    return [UMSPPPayUnifyPayPlugin handleOpenURL:url];
};
#pragma mark 获取当前显示的VC
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}
-(void)receive:(NSDictionary *)userInfo{
    NSLog(@"收到数据：%@",userInfo);
}



- (void)archiver {
    
    //把复杂文件写入文件，先转化为nsdata对象
    //归档：归档的实质就是把其他类型的数据（person），先转化为NSData,再写入文件。
    userInfoModel *user = [userInfoModel sharedUser];
    //    NSKeyedArchiver  压缩工具类，继承自NSCoder，主要用于编码
    NSMutableData *data = [NSMutableData data] ;
    NSKeyedArchiver *achiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //使用压缩工具讲Person压到data中
    [achiver encodeObject:user forKey:@"userInfo"];
    //完成压缩，停掉压缩工具
    [achiver finishEncoding];
    
    
    NSString *homePath = NSHomeDirectory();
    NSString *toPath = [homePath stringByAppendingPathComponent:@"userInfo.txt"];
    BOOL isSuccess = [data writeToFile:toPath atomically:YES];
    NSLog(@"%@",isSuccess ? @"成功" : @"失败");
    
    //复杂对象的读取，反归档
    //    NSKeyedUnarchiver
    NSData *getData = [NSData dataWithContentsOfFile:toPath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:getData];
    //解压
    userInfoModel *user1 = [unArchiver decodeObjectForKey:@"userInfo"];
    NSLog(@"%@", user1);
    [unArchiver finishDecoding];
}





@end
