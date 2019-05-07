//
//  JFLocationSingleton.m
//  HanPay
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "JFLocationSingleton.h"

@implementation JFLocationSingleton
+(instancetype)sharedInstance{
    static JFLocationSingleton *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JFLocationSingleton new];
    });
    return instance;
}
@end
