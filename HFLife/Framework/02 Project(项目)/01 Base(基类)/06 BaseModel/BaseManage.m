//
//  BaseManage.m
//  HFLife
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseManage.h"

@implementation BaseManage
+(instancetype)sharedInstance{
    static BaseManage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super new];
    });
    return instance;
}
@end
