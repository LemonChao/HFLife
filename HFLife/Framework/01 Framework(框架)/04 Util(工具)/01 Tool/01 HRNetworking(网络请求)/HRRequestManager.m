

#import "HRRequestManager.h"

@implementation HRRequestManager

#pragma mark - ---------- Lifecycle ----------

#pragma mark - ---------- Public Methods ----------
#pragma mark GET请求
- (void)GET_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    [self requestWay:HRHttpRequestMethodGet url:url params:params progress:progress success:success failure:failure];
}

#pragma mark POST请求
- (void)POST_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    [self requestWay:HRHttpRequestMethodPost url:url params:params progress:progress success:success failure:failure];
}



#pragma mark 表单请求
- (void)FORM_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    [self requestWay:HRHttpRequestMethodForm url:url params:params progress:progress success:success failure:failure];
}
#pragma mark 上传请求
- (void)Update_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    [self requestWay:HRHttpRequestMethodUpdate url:url params:params progress:progress success:success failure:failure];
}

#pragma mark DownLoad请求
- (void)DownLoad_URL:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    [self requestWay:HRHttpRequestMethodDownLoad url:url params:params progress:progress success:success failure:failure];
}




#pragma mark - ---------- Private Methods ----------
//处理请求
- (void)requestWay:(HRHttpRequestMethod)method url:(NSString *)url params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    self.requestUrl = url;
    self.requestParams = params;
    self.requestMethod = method;
    [self requestProgress:^(NSProgress *p) {
        //进度回调
        if (progress) {
            progress(p);
        }
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.userInfo);
        }
    }];
}

@end
