
/*
 个人信息管理类别(线程安全的单例)
 */
#import "HRUserInfoManager.h"

static HRUserInfoManager *_instance = nil;
@implementation HRUserInfoManager

+ (instancetype)getInstance
{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc]init];
        }
    }
    return _instance;
}

#pragma mark -overide

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self){
        if (!_instance) {
             _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return _instance;
}



@end
