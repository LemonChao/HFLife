

#import "HRBaseRequest.h"


@interface HRRequestManager : HRBaseRequest

#pragma mark GET请求
- (void)GET_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark POST请求
- (void)POST_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;



#pragma mark Update请求

- (void)Update_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark DownLoad请求
- (void)DownLoad_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;


#pragma mark 表单请求
- (void)FORM_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

@end
