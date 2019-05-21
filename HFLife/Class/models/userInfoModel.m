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
@end
