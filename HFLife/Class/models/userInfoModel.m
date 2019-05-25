//
//  userModel.m
//  DeliveryOrder
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import "userInfoModel.h"

@implementation userInfoModel
static userInfoModel *_user;
//static dispatch_once_t onceToken; 这个拿到函数体外,成为全局的.才能实现单例的销毁
static dispatch_once_t onceToken;
+(instancetype)sharedUser{
    dispatch_once(&onceToken, ^{
        if (!_user) {
            _user = [[userInfoModel alloc] init];
        }
    });
    
    return _user;
    
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"找不到的：key-%@=====value-%@" , key , value);
    if ([value isKindOfClass:[NSNull class]] || value == nil) {
        NSLog(@"！！！！！！！！！---------------------数据类型位---<Null>---value = %@" , value);
        //设置数据为@"";
        value = @"";
        [self setValue:value forKeyPath:key];
    }
    if ([key isEqualToString:@"description"]) {
        key = @"Mydescription";//
        [self setValue:value forKeyPath:@"Mydescription"];
    }
    if ([key isEqualToString:@"id"]) {
        key = @"ID";//小写id转大写ID
        [self setValue:value forKeyPath:@"ID"];
    } else {
        NSLog(@"您尝试设置的key：%@不存在",key);
        NSLog(@"您尝试设置的value：%@",value);
    }
}

















//单例的销毁
+(void)attempDealloc{
    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    _user = nil;
}

//实名认证状态 0未认证   1已认证   2审核中   3未通过
- (NSString *)rz_statusName {
    if (self.rz_status.intValue == 0) {
        return @"未认证";
    }
    if (self.rz_status.intValue == 1) {
        return @"已认证";
    }
    if (self.rz_status.intValue == 2) {
        return @"审核中";
    }
    if (self.rz_status.intValue == 3) {
        return @"未通过";
    }
    return @"";
}

//性别 0保密 1男 2女
- (NSString *)member_sexName {
    if (self.member_sex.intValue == 0) {
        return @"保密";
    }
    if (self.member_sex.intValue == 1) {
        return @"男";
    }
    if (self.member_sex.intValue == 2) {
        return @"女";
    }
    return @"";
}


//拼接推送的别名
// 拼接id 不够补0
- (NSString *)appendStr:(NSString *)user_id{
    NSString *firstStr = JPUSH_TYPERIES;
    NSString *sourceStr = @"000000000000";
    
    NSString *appendStr = [sourceStr substringWithRange:NSMakeRange(0, 7 - user_id.length)];
    NSString *backStr = [NSString stringWithFormat:@"%@%@%@",firstStr,appendStr, user_id];
    NSLog(@"拼接后的字符串");
    return backStr;
}



@end

