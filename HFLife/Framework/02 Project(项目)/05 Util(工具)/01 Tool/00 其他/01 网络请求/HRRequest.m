

#import "HRRequest.h"
#import "HR_dataManagerTool.h"

@implementation HRRequest

//初始化（单例）如果涉及同时多次请求 那么就不能使用单利
+ (instancetype)manager {
  		static id instance = nil;
//          static dispatch_once_t onceToken;
//          dispatch_once(&onceToken, ^{
            instance = [[super allocWithZone:NULL] init];
//        });
  		return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[self class] manager];
}
- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [[self class] manager];
}

#pragma mark - ---------- Public Methods ----------

#pragma mark POST请求
- (void)GET:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure {
    //网络异常处理
    if ([self handleNetNotWork:failure]) {
        return;
    }
    //
    [self GET_PATH:path params:para progress:^(NSProgress *progress) {
        if (progressResult) {
            progressResult(progress);
        }
    } success:^(id result) {
        //处理请求结果返回值
        [self handleResult:result success:success failure:failure];
    } failure:^(NSDictionary *errorInfo) {
        //处理请求异常
        [self handleRequestError:errorInfo failure:failure];
    }];
}

- (void)POST:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure {
  
    //网络异常处理
    if ([self handleNetNotWork:failure]) {
        return;
    }
    //
    [self POST_PATH:path params:para progress:^(NSProgress *progress) {
        if (progressResult) {
            progressResult(progress);
        }
    } success:^(id result) {
        //处理请求结果返回值
        [self handleResult:result success:success failure:failure];
    } failure:^(NSDictionary *errorInfo) {
        //处理请求异常
        [self handleRequestError:errorInfo failure:failure];
    }];
}
//上传图片
- (void) UpDate:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure{
    //网络异常处理
    if ([self handleNetNotWork:failure]) {
        return;
    }
    
    [self Update_PATH:path params:para peogress:^(NSProgress *progress) {
        //回调返回值
        if (progressResult) {
            progressResult(progress);
        }
    } success:^(id result) {
        //处理请求结果返回值
        [self handleResult:result success:success failure:failure];
    } failure:^(NSDictionary *errorInfo) {
        //处理请求异常
        [self handleRequestError:errorInfo failure:failure];
    }];
}

- (void) DownLoad:(NSString *)path para:(NSDictionary *)para progress:(Progress)progressResult success:(Success)success faiulre:(Failure)failure{
    //网络异常处理
    if ([self handleNetNotWork:failure]) {
        return;
    }
    [self DownLoad_PATH:path params:para peogress:^(NSProgress *progress) {
        //回调返回值
        if (progressResult) {
            progressResult(progress);
        }
    } success:^(id result) {
        //处理请求结果返回值
        [self handleResult:result success:success failure:failure];
    } failure:^(NSDictionary *errorInfo) {
        //处理请求异常
        [self handleRequestError:errorInfo failure:failure];
    }];
}





#pragma mark - ---------- Private Methods ----------
//处理网络异常
- (BOOL)handleNetNotWork:(Failure)failure {
    if (self.netStatus == HRNetStatusUnknown || self.netStatus == HRNetStatusNotReachable) {
        if (failure) {
            NSLog(@"错误提示信息可在 \"[02 project] -> [05 Common] -> [Contant.h] 中修改常量 \"NET_NOT_WORK\" 值");
            failure(NET_NOT_WORK);
        }
        return YES;
    }
    return NO;
}
//处理请求异常
- (void)handleRequestError:(NSDictionary *)errorInfo failure:(Failure)failure {
    if (errorInfo) {
        NSLog(@"错误提示信息可在 [02 project] -> [05 Common] -> [Contant.h] 中修改常量 \"ERROR_MESSAGE\" 值");
        if (failure) {
            failure(ERROR_MESSAGE);
        }
    }
}
//处理请求结果返回值
- (void)handleResult:(id)result success:(Success)success failure:(Failure)failure {
    //此处可修改 success -> status，或者其他参数名称， 值的判断同理
    
    
    //data 转json
    NSDictionary *valueDict = [HR_dataManagerTool dataToJson:result];
    
    
//    if ([valueDict[@"code"] integerValue] == 1) {
//        //data 可修改，原理同上
//        success(valueDict);
//    } else {
//        //errorMsg 可修改，原理同上
//        success(valueDict);
//    }
    success(valueDict);
    
//    if ([valueDict[@"success"] integerValue] == 1) {
//        //data 可修改，原理同上
//        success(valueDict[@"data"]);
//    } else {
//        //errorMsg 可修改，原理同上
//        failure(valueDict[@"errorMsg"]);
//    }
}

@end
