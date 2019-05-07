


#import "HRRequestManager.h"


@interface HRNetworkingManager : HRRequestManager

#pragma mark GET请求
- (void)GET_PATH:(NSString *)path params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark POST请求
- (void)POST_PATH:(NSString *)path params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark Update请求
- (void)Update_PATH:(NSString *)path params:(NSDictionary *)params peogress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;
#pragma mark DownLoad请求
- (void)DownLoad_PATH:(NSString *)path params:(NSDictionary *)params peogress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

@end
