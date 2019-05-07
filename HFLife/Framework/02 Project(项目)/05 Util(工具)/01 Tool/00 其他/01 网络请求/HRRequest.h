/*
 项目网络请求
 可拓展
 */

#import "HRNetworkingManager.h"

typedef void(^Success)(id data);
typedef void(^Failure)(id errMsg);
typedef void(^Progress)(NSProgress *progressResult);
@interface HRRequest : HRNetworkingManager
//初始化（单例）
+ (instancetype)manager;

//1.0 GET请求
- (void)GET:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure;

//2.0 POST请求
- (void)POST:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure;

//3.0 上传图片请求
- (void)UpDate:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure;

//4.0 下载文件
- (void)DownLoad:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure;
@end
