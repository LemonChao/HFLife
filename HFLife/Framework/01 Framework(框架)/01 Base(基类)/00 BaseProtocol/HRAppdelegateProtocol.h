

#import <Foundation/Foundation.h>
#import "HRBaseProtocol.h"

@protocol HRAppdelegateProtocol <HRBaseProtocol>

@required
//配置根视图
- (void)configRootViewController;

@optional
//配置网络监测环境
- (void)configNetStatusMoniterEnvironment;
//配置分享环境
- (void)configShareEnvironment;
//配置推送环境
- (void)configPushEnvironment;
//配置定位服务环境
- (void)configLocationServiceEnvironment;
//配置地图环境
- (void)configMapEnvironment;
//配置支付环境
- (void)configPayEnvironment;


@end
