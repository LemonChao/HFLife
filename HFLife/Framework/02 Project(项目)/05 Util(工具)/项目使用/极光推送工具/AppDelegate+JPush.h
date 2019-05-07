//
//  AppDelegate+JPush.h
//  QQRunning
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 软盟. All rights reserved.
//

#import "AppDelegate.h"
//#import "SDJPushHelper.h"
static AVSpeechSynthesizer *synth;
@interface AppDelegate (JPush)<AVSpeechSynthesizerDelegate,JPUSHRegisterDelegate>
//@property (nonatomic,strong) AVSpeechSynthesizer *synth;


/**
 初始化极光推送
 
 @param application UIApplication对象
 @param launchOptions NSDictionary 对象
 @param delegate 代理
 */
-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions delegate:(id<JPUSHRegisterDelegate>)delegate;

/**
 处理推送
 
 @param dic 字典
 @return 返回字符串
 */
- (NSString *)logDic:(NSDictionary *)dic;


/**
 收到通知后语音播报

 @param title 播放内容
 @param isDelegate 是否代理
 */
- (void)PlayVoiceTitle:(NSString *)title isDelegate:(BOOL)isDelegate;

/**
 处理进入后台时会发生的问题
 */
-(void)backstageHandle;

/**
 预防处理音频错误
 */
-(void)errorHandle;

/**
 停止播放
 */
- (void)stopJPushSpeak;

/**
 清空角标
 */
-(void)reinstallBadge;
@end
