

#import "HRNetworkingManager.h"

@implementation HRNetworkingManager

#pragma mark - ---------- Public Methods ----------

#pragma mark GET请求
- (void)GET_PATH:(NSString *)path params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    //处理显示请求信息
    [self handleShowRequestMessageUrlWithPath:path params:params];
    
    [self GET_URL:composeUrl(path) params:params progress:^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } success:^(id result) {
        //处理显示请求成功信息
        [self handleResultMessage:result];
        //成功回调
        if (success) {
            success(result);
        }
    } failure:^(NSDictionary *errorInfo) {
        //处理显示请求失败信息
        [self handleResultMessage:errorInfo];
        //失败回调
        if (failure) {
            failure(errorInfo);
        }
    }];
}

#pragma mark POST请求
- (void)POST_PATH:(NSString *)path params:(NSDictionary *)params progress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    //处理显示请求信息
    [self handleShowRequestMessageUrlWithPath:path params:params];
    //请求
    [self POST_URL:composeUrl(path) params:params progress:^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } success:^(NSDictionary *result) {
        //处理显示请求成功信息
        [self handleResultMessage:result];
        //成功回调
        if (success) {
            success(result);
        }
    } failure:^(NSDictionary *errorInfo) {
        //处理显示请求失败信息
        [self handleResultMessage:errorInfo];
        //失败回调
        if (failure) {
            failure(errorInfo);
        }
    }];
}

#pragma mark Update请求
- (void)Update_PATH:(NSString *)path params:(NSDictionary *)params peogress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    //处理显示请求信息
    [self handleShowRequestMessageUrlWithPath:path params:params];
    //请求
    [self Update_URL:path params:params progress:^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } success:^(id result) {
        //处理显示请求成功信息
        [self handleResultMessage:result];
        //成功回调
        if (success) {
            success(result);
        }
    } failure:^(NSDictionary *errorInfo) {
        [self handleResultMessage:errorInfo];
        //失败回调
        if (failure) {
            failure(errorInfo);
        }
    }];
}
#pragma mark DownLoad请求
- (void)DownLoad_PATH:(NSString *)path params:(NSDictionary *)params peogress:(void(^)(NSProgress *progress))progressBlock success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    //处理显示请求信息
    [self handleShowRequestMessageUrlWithPath:path params:params];
    //请求
    [self Update_URL:path params:params progress:^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } success:^(id result) {
        //处理显示请求成功信息
        [self handleResultMessage:result];
        //成功回调
        if (success) {
            success(result);
        }
    } failure:^(NSDictionary *errorInfo) {
        [self handleResultMessage:errorInfo];
        //失败回调
        if (failure) {
            failure(errorInfo);
        }
    }];
}




#pragma mark - ---------- Private Methods ----------
//拼接URL
static inline NSString * composeUrl(NSString *path) {
    return SF(@"%@%@%@%@%@", URL_PROTOCOL, URL_HOST, URL_PORT, URL_PATH_PREFIX, path);
}
//处理显示请求信息
- (void)handleShowRequestMessageUrlWithPath:(NSString *)path params:(NSDictionary *)params {
    if (self.showLog) {
        HRLog(@"URL:%@", composeUrl(path));
        HRLog(@"Params:%@", params);
    }
}
//处理显示请求成功信息
- (void)handleResultMessage:(NSDictionary *)result {
    if (self.showLog) {
        //打印返回结果
        HRLog(@"Result:%@", result);
    }
}


@end
