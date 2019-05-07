//
//  AppDelegate+JAnalytics.m
//  HanPay
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AppDelegate+JAnalytics.h"
#import "JANALYTICSService.h"
@implementation AppDelegate (JAnalytics)
-(void)JAnalyticsApplication:(UIApplication *)applicatio didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    
    config.appKey = kJPAppKey;
    
    config.channel = @"AppStore";
    
    [JANALYTICSService setupWithConfig:config];
    
    [JANALYTICSService crashLogON];
}

@end
