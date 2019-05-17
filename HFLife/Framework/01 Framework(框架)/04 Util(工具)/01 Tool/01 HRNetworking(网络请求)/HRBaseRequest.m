

#import "HRBaseRequest.h"
#import "AFNetworking.h"
#import "NSDictionary+UnicodeToChinese.h"

@interface HRBaseRequest ()

//网络请求(公开配置)
//@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
//成功block
@property (copy, nonatomic) void(^successBlock)(id responseObject);
//失败block
@property (copy, nonatomic) void(^failureBlock)(NSError *error);

@end

@implementation HRBaseRequest

#pragma mark - ---------- Lazy Loading ----------

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        //初始化requestSerializer
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置响应文件类型为JSON类型
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"image/png", @"application/octet-stream", @"text/json",@"multipart/form-data", @"text/javascript",@"text/html", nil];
        //获取请求头
//        _sessionManager.requestSerializer.HTTPRequestHeaders
        
        
        
    }
    return _sessionManager;
}

#pragma mark - ---------- Lifecycle ----------

#pragma mark - ---------- Lifecycle ----------

- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化各属性默认参数
        _requestType = HRRequestModeHttp;
        _requestWay = HRHttpRequestWayAsync;
        _requestMethod = HRHttpRequestMethodPost;
        _requestUrl = @"";
        _requestParams = @{};
        _requestTimeOut = 10.f;
        _requestCryptType = HRRequestCryptTypeNone;
        
        //清空缓存信息
        _error = nil;
        //默认未开始监测
        _netStatus = HRNetStatusNotMoniter;
        //默认打印日志
        _showLog = YES;
    }
    return self;
}

#pragma mark - ---------- Public Methods ----------
//发送请求
- (void)requestProgress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    self.progressBlock = progress;
    self.successBlock = success;
    self.failureBlock = failure;
    //刷新请求超时时间
    self.sessionManager.requestSerializer.timeoutInterval = self.requestTimeOut;
    //请求类型（http\socket）
    if (self.requestType == HRRequestModeHttp) {
        [self http];
    } else {
        [self socket];
    }
}

#pragma mark - ---------- Private Methods ----------
//短链接
- (void)http {
    //请求方式（同步\异步）
    if (self.requestWay == HRHttpRequestWayAsync) {
        [self async];
    } else {
        [self sync];
    }
}
//长链接
- (void)socket {
    //长链接 预留功能
}
//异步
- (void)async {
    //请求方法(GET\POST\FORM)
    switch (self.requestMethod) {
        case HRHttpRequestMethodGet: {
            [self GET];
        }
            break;
        case HRHttpRequestMethodPost: {
            [self POST];
        }
            break;
        case HRHttpRequestMethodForm: {
            [self FORM];
        }
            break;
        case HRHttpRequestMethodUpdate: {
            [self Update];
        }
            break;
        case HRHttpRequestMethodDownLoad:{
            [self DowbnLoad];
        }
            break;
        default:
            break;
    }
}
//同步
- (void)sync {
    //同步。预留功能
}
//GET
- (void)GET {
    [self.sessionManager GET:self.requestUrl parameters:self.requestParams progress:^(NSProgress * _Nonnull downloadProgress) {
        if (self.progressBlock) {
            self.progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.successBlock(responseObject);
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
        self.failureBlock(error);
    }];
}
//POST
- (void)POST {
    [self.sessionManager POST:self.requestUrl parameters:self.requestParams progress:^(NSProgress * _Nonnull uploadProgress) {
        if (self.progressBlock) {
            self.progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self.successBlock) {
            self.successBlock(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _error = error;
        if (self.failureBlock) {
            self.failureBlock(error);
        }
    }];
}
//FORM
- (void)FORM {
    //表单 预留功能
    
}
//上传
- (void)Update {
    //
    //1. 创建会话管理者
   
    
    //2. 发送post请求上传文件
    /*
     第一个参数:请求路径
     第二个参数:字典(非文件参数)可以传nil
     第三个参数:constructingBodyWithBlock 处理要上传的文件数据
     第四个参数:进度回调
     第五个参数:成功回调 responseObject:响应体信息
     第六个参数:失败回调
     */
#pragma mark - 随机文件名上传 
    [self.sessionManager POST:self.requestUrl parameters:self.requestParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 单独添加配置 配置下请求
        self.sessionManager.responseSerializer.acceptableContentTypes = nil;
        
        //设置timeout
        [self.sessionManager.requestSerializer setTimeoutInterval:20.0];
        
        //设置请求头类型
        [self.sessionManager.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
        
        UIImage *image;
        NSData *imageData = UIImageJPEGRepresentation(image, 0);
        
        
        // 使用formData来拼接数据
        /*
         param1: 二进制数据 要上传的文件参数
         param2: 服务器规定的
         param3: 该文件上传到服务器以什么名称保存
         */
        //通过data上传
        // [formData appendPartWithFileData:imageData name:@"file" fileName:@"zy.jpg" mimeType:@"image/jpg"];
        //通过本地路径上传
//         [formData appendPartWithFileURL:[NSURL fileURLWithPath:self.requestParams[@"filePath"]] name:@"file" error:nil];
        NSError *error;
         BOOL success = [formData appendPartWithFileURL:[NSURL fileURLWithPath:@""] name:@"file" fileName:@"zy.jpg" mimeType:@"image/jpg" error:nil];
        if (!success) {
            NSLog(@"formData拼接失败！！！");
            NSLog(@"appendPartWithFileURL error: %@", error);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        if (self.progressBlock) {
            self.progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.successBlock) {
            self.successBlock(responseObject);
        }
        NSLog(@"上传成功---%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.failureBlock) {
            self.failureBlock(error);
        }
        NSLog(@"上传失败---%@",error);
    }];
}
//下载
- (void) DowbnLoad{
    
    /*
     param1: 请求对象
     param2: progress 进度回调 downloadProgress
     
     param3: destination回调 (目标位置)
     有返回值
     targetPath:临时文件的路径(相当于Location)
     response: 响应头信息
     
     param4: completionHanler 下载完之后的回调
     filePath: 最终文件的下载路径
     */
    
    NSURL *url = [NSURL URLWithString:self.requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *download = [self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 下载进度
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        if (self.progressBlock) {
            self.progressBlock(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 内部已经 默认做了剪切操作(临时数据 剪切 到文件指定位置)
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:response.suggestedFilename];
        
        NSLog(@"targetPath--%@",targetPath);
        NSLog(@"fullPath--%@",fullPath);
        return [NSURL fileURLWithPath:fullPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath--%@",filePath);
        if (!error) {
            if (self.successBlock) {
                self.successBlock(response);
            }
        }else{
            if (self.failureBlock) {
                self.failureBlock(error);
            }
        }
    }];
    
    //4. 执行task
    [download resume];
}
@end
