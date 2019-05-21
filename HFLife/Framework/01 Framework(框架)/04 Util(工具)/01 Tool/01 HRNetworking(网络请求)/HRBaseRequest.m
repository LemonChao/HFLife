

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
    
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.requestParams];
    [dictM removeObjectForKey:@"image"];
    [self.sessionManager POST:self.requestUrl parameters:dictM constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 单独添加配置 配置下请求
        //        self.sessionManager.responseSerializer.acceptableContentTypes = nil;
        
        //设置timeout
        [self.sessionManager.requestSerializer setTimeoutInterval:20.0];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"image/png", @"application/octet-stream", @"text/json",@"multipart/form-data",@"image/jpg",  nil];
        //设置请求头类型
        [self.sessionManager.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
        
        UIImage *image;
        NSURL *fileUrl;
        if ([self->_requestParams valueForKey:@"image"]) {
            if ([[self->_requestParams valueForKey:@"image"] isKindOfClass:[UIImage class]]) {
                //图片
                image =  self->_requestParams[@"image"];
            }else if([[self->_requestParams valueForKey:@"image"] isKindOfClass:[NSString class]]){
                //图片地址
                fileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [NSURL URLWithString:self->_requestParams[@"image"]]]];
                image = [UIImage imageWithContentsOfFile:self->_requestParams[@"image"]];
            }else if ([[self->_requestParams valueForKey:@"image"] isKindOfClass:[NSURL class]]){
                //图片地址
                fileUrl = self->_requestParams[@"image"];
                image = [[UIImage alloc] initWithContentsOfFile:fileUrl.absoluteString];
            }
            
        }else{
            NSLog(@"error :请拼接图片 image: @"" ");
            [CustomPromptBox showTextHud:@"error :请拼接图片 image: @"" "];
            return ;
        }
        // 使用formData来拼接数据
        
        {
            /*
             param1: 二进制数据 要上传的文件参数
             param2: 服务器规定的
             param3: 该文件上传到服务器以什么名称保存
             */
            NSData *imageData = UIImagePNGRepresentation([self getNewImage : image]);
            
            NSLog(@"图片大小%.2f M", imageData.length / 1024.0 / 1024.0);
            //随机图片名
            NSString *imageName = [self generateTradeNO];
            //通过data上传
            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.png", imageName] mimeType:@"image/jpg/png"];
        }

        /*
         {
         //路径上传
         NSError *error;
         //name 必须为服务器的约定的
         //filename 自己定义  xxx.png/jpg
         
         
         
         NSInteger imgCount = 0;
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
         BOOL success = [formData appendPartWithFileURL:fileUrl name:@"img" fileName:fileName mimeType:@"image/jpg/png" error:nil];
         if (!success) {
         NSLog(@"formData拼接失败！！！");
         NSLog(@"appendPartWithFileURL error: %@", error);
         }
         }
         */
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



- (UIImage *) getNewImage:(UIImage *)image{
    //设定为 1M
    return  [self compressImageQuality:image toByte:1024 * 1024];
}



//产生随机字符串
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


//压缩图片（通过压缩图片质量）
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

//压缩图片质量 循环次数较少 消耗低 优于上一种
/**
 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。最多压缩 6 次，1/(2^6) = 0.015625 < 0.02，也能达到每次循环 compression 减小 0.02 的效果。这样的压缩次数比循环减小 compression 少，耗时短。需要注意的是，当图片质量低于一定程度时，继续压缩没有效果。也就是说，compression 继续减小，data 也不再继续减小。压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。
 
 设定小于1M  就是  maxLength = 1024 x 1024
 */
- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}

//压缩图片尺寸来达到目的
/**
 与之前类似，比较容易想到的方法是，通过循环逐渐减小图片尺寸，直到图片稍小于指定大小(maxLength)。具体代码省略。同样的问题是循环次数多，效率低，耗时长。可以用二分法来提高效率，具体代码省略。这里介绍另外一种方法，比二分法更好，压缩次数少，而且可以使图片压缩后刚好小于指定大小(不只是 < maxLength， > maxLength * 0.9)。
 */
+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength {
    UIImage *resultImage = image;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        // Use image to draw (drawInRect:), image is larger but more compression time
        // Use result image to draw, image is smaller but less compression time
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return resultImage;
}





/** 生成缩略图的方法 */
- (UIImage *) thumnaiWithImage:(UIImage *) image size:(CGSize) size
{
    //    image lenth = 11314085byt
    //    newimage lenth = 29378byt
    //    sendData lenth = 1505
    //    压缩了400倍
    UIImage *newImage = nil;
    if (!newImage)
    {
        UIGraphicsBeginImageContext(size);//获取绘制开始的上下文
        [image drawInRect:CGRectMake(0, 0, size.width, size.width)];//重新绘制一个图片
        newImage = UIGraphicsGetImageFromCurrentImageContext();//获取绘制过得图片上下文
        UIGraphicsEndImageContext();//结束绘制
    }
    return newImage;
}



@end
