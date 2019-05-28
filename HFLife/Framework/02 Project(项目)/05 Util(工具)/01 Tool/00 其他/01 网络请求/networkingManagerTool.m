

//
//  networkingManagerTool.m
//  门口农场
//
//  Created by SXF on 16/9/8.
//  Copyright © 2016年 Consequently there door. All rights reserved.
//

#import "networkingManagerTool.h"
#import "setCookiesTool.h"
#import "HRRequest.h"
#import "HR_dataManagerTool.h"
#import "LoginVC.h"
#import "RSAEncryptor.h"

@interface networkingManagerTool()

@end

@implementation networkingManagerTool
+ (networkingManagerTool *)sharedFMDBManager
{
    static networkingManagerTool *plManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        plManager = [[networkingManagerTool alloc]init];
//    });
    return plManager;
}

/*
//发送请求  获得验证码图片数据
+(void)getAuthCodeWithBlock:(imageBlock)block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@%@" , BASEURL , @"vcode.php"] parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        UIImage *image = [UIImage imageWithData:responseObject];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        }];
        NSLog(@"验证码获取成功%@" , image);
        //获取储存到本地 并设置
        [[[setCookiesTool alloc] init] saveHttpCookie];
        [[[setCookiesTool alloc] init] loadHttpCookie];
        
        block(image);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            [MBProgressHUD showError:@"获取验证码失败"];
        }];
        NSLog(@"验证码获取失败%@",error);
    }];
}



//获取图片
+(void)getfarmImageWithWithUrl:(NSString *)imageUrl Block:(imageBlock)block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@%@" , BASEURL , imageUrl] parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        UIImage *image = [UIImage imageWithData:responseObject];
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        }];
        block(image);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil);
    }];
}
*/

//不带控制器
+ (void) requestToServerWithType:(NSString *)RequestType withSubUrl:(NSString *)subUrl withParameters:(NSDictionary *)parameters withResultBlock:(ValueBlock)valueBlock{
    [networkingManagerTool requestToServerWithType:RequestType withSubUrl:subUrl withParameters:parameters withResultBlock:valueBlock witnVC:nil];
}





//不显示进度
+ (void) requestToServerWithType:(NSString *)RequestType withSubUrl:(NSString *)subUrl withParameters:(NSDictionary *)parameters withResultBlock:(ValueBlock)valueBlock witnVC:(UIViewController *)VC{
    [networkingManagerTool requestToServerWithType:RequestType withSubUrl:subUrl withParameters:parameters progress:nil withResultBlock:valueBlock witnVC:VC];
}
//显示进度
+ (void) requestToServerWithType:(NSString *)RequestType withSubUrl:(NSString *)subUrl withParameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *progress))progress withResultBlock:(ValueBlock)valueBlock witnVC:(UIViewController *)VC
{
    HRRequest *requestManager = [HRRequest manager];
    
    
    
    /**********************配置g公参*************************/
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    /*******************************************************/
    
    
    
    /**********************配置header*************************/
    
    
    //做sin签名
    NSString *sinStr = [[NSString stringWithFormat:@"%@&%@&%@&%@", @"c9dfaa769668ac047ff0e72a7fecb991", subUrl, [NSDate currentTimeStamp10], [self getAppVersion]] lowercaseString];
    NSString *sha256Str = [sinStr SHA256];
    //设置请求头
    //签名sin
    [requestManager.sessionManager.requestSerializer setValue:sha256Str forHTTPHeaderField:@"SIGN"];
    //appVersion
    [requestManager.sessionManager.requestSerializer setValue:[self getAppVersion] forHTTPHeaderField:@"VERSION"];
    
    //currentTime
    [requestManager.sessionManager.requestSerializer setValue:[NSDate currentTimeStamp10] forHTTPHeaderField:@"TIME"];
    //    [requestManager.sessionManager.requestSerializer setValue:@"ffffffff-8fb3-968f-0000-00004bcc6045" forHTTPHeaderField:@"device"];
    [requestManager.sessionManager.requestSerializer setValue:[SFHFKeychainUtils GetIOSUUID] forHTTPHeaderField:@"device"];

    //设置token
    NSString *gettoken = [[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN];
    //token 设置到请求头上
//    gettoken = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaW5mbyI6eyJpZCI6MzIsIm1lbWJlcl9tb2JpbGUiOiIxODU2OTkzOTEyNCIsImFsaXBheV91bmlvbmlkIjpudWxsLCJ3ZWl4aW5fdW5pb25pZCI6bnVsbCwicmVhbG5hbWUiOiIiLCJtZW1iZXJfYXZhdGFyIjoiIiwibWVtYmVyX3NleCI6MCwibWVtYmVyX2VtYWlsIjpudWxsLCJpbnZpdGVyX2lkIjowLCJuaWNrbmFtZSI6IjE4NTY5OTM5MTI0Iiwicnpfc3RhdHVzIjowLCJ0b2tlbiI6IjE0MmQ4NjdiZDg4MTAzYzIxMDBjM2FkYzM1NWIwODdjMmM5MDVmNGYifSwidGltZSI6MTU2MTM0ODQxMCwidG9rZW4iOiIxNDJkODY3YmQ4ODEwM2MyMTAwYzNhZGMzNTViMDg3YzJjOTA1ZjRmIn0.hk0CKWYf6yo2nfsQ58zL65wnJshA7G5jZXp6fwXDzsA";
    gettoken = @"05bd0b6950c78fac59335515f5fcfdab";
    if (gettoken) {
        [requestManager.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%@" , gettoken] forHTTPHeaderField:@"TOKEN"];
    }else {
//        [LoginVC login];

//        return;
    }
    NSLog(@"httpHeaders : %@", requestManager.sessionManager.requestSerializer.HTTPRequestHeaders);
    /********************************************************/
    
    
    
    
    //GET
    if ([RequestType isEqualToString:GET]) {
        [requestManager GET:subUrl para:parameters progress:^(NSProgress *progressResult) {
            progress(progressResult);
        } success:^(id data) {
            [[networkingManagerTool sharedFMDBManager] getDataAnalysisWith:data withresultBlock:valueBlock withvc:VC];
        } faiulre:^(NSString *errMsg) {
            
        }];
    }//POST
    else if ([RequestType isEqualToString:POST]) {
        [requestManager POST:subUrl para:parameters progress:^(NSProgress *progressResult) {
            if (progress) {
                progress(progressResult);
            }
        } success:^(id data) {
            [[networkingManagerTool sharedFMDBManager] getDataAnalysisWith:data withresultBlock:valueBlock withvc:VC];
        } faiulre:^(NSString *errMsg) {
            valueBlock(NO, nil);
        }];
    }//PUT
    else if ([RequestType isEqualToString:PUT]) {
        
    }
//    上传 数据流上传
    else if ([RequestType isEqualToString:UPDATE]) {
        [requestManager UpDate:subUrl para:parameters progress:^(NSProgress *progressResult) {
            if (progress) {
               progress(progressResult);
            }
        } success:^(id data) {
            [[networkingManagerTool sharedFMDBManager] getDataAnalysisWith:data withresultBlock:valueBlock withvc:VC];
        } faiulre:^(NSString *errMsg){
            
        }];
    }
    else if ([RequestType isEqualToString:DOWNLOAD]) {
        [requestManager DownLoad:subUrl para:parameters progress:^(NSProgress *progressResult) {
            if (progress) {
                progress(progressResult);
            }
        } success:^(id data) {
            
        } faiulre:^(id errMsg) {
            
        }];
    }

}




//上传图片   base64上传
+ (void)upLoadImageWithBase64WithImage:(UIImage *)image withSubUrl:(NSString *)subUrl progress:(progressBlock)progress withResultBlock:(void (^)(BOOL, id))resultBlock witnVC:(UIViewController *)VC
{
    //根据url初始化request
    
    HRRequest *requestManager = [HRRequest manager];
    NSData* data;
    NSData *newData;
    NSString *type;
    if(image){
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
            newData = data;
            type = @".png";
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.f);
            //                CGFloat size = 2048.f;// kb
            CGFloat size = 100.f;
            CGFloat scale = size/(data.length/1024);
            newData= UIImageJPEGRepresentation(image, scale);
            type = @".jpeg";
        }
    }
    NSString *encodedImageStr = [newData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //Base64字符串转UIImage图片：
    
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 400)];
    [imgView setImage:decodedImage];
    NSLog(@"decodedImage==%@",decodedImageData);
    
    NSString *gettoken = [[NSUserDefaults standardUserDefaults] valueForKey:@"Token"];
    gettoken = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjcsImlzcyI6Imh0dHA6Ly9qci5kdWR1YXBwLm5ldC9hcGkvc2lnbiIsImlhdCI6MTUyMDU4MDIwMCwiZXhwIjoxNTIzMTcyMjAwLCJuYmYiOjE1MjA1ODAyMDAsImp0aSI6IlJOeEJhZmdpendzOXd2SHYifQ.yEkQZ3pfM9--_MMBKD3ypFg8X5McuGsZJyCnSFSpbos";
    if (gettoken) {
//        [requestManager setHTTPHeaderFieldValue:[NSString stringWithFormat:@"Bearer %@" , gettoken] forKey:@"Authorization"];
    }
    
    
    NSDictionary *parameters = @{@"file" : encodedImageStr , @"token" :gettoken};
    NSLog(@"请求参数是：%@" , parameters);
    
    
    [requestManager POST:subUrl para:parameters progress:^(NSProgress *progressResult) {
        progress(progressResult);
    } success:^(id data) {
        [[networkingManagerTool sharedFMDBManager] getDataAnalysisWith:data withresultBlock:resultBlock withvc:VC];
    } faiulre:^(NSString *errMsg) {
        
    }];
   
}

- (void) getDataAnalysisWith:(id)responseObject withresultBlock:(ValueBlock)valueBlock withvc:(UIViewController *)vc
{
    UIViewController *currentVC;
    if (![vc isKindOfClass:[UIViewController class]]) {
        currentVC = [self getCurrentViewController];
    }else{
        currentVC = vc;
    }
    
    //成功  返回就是json  不需要解析
    NSDictionary *valueDic = [HR_dataManagerTool dataToypteDJson:responseObject];
    NSLog(@"result = %@" , valueDic);
    //解析正确
    if (valueDic != nil) {
        if ([valueDic[@"status"] integerValue] == 1){
            //成功
            valueBlock(YES , valueDic);
        }else if ([valueDic[@"status"] integerValue]  == 0){
            //失败
            valueBlock(NO , valueDic);
        }else if([valueDic[@"status"] integerValue]  == -1){
            //登陆过期
            valueBlock(NO , valueDic);
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USER_TOKEN];
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:LOGIN_STATES];
            [userInfoModel attempDealloc];

            [LoginVC login];
        }else{
            
        }
    }
}





- (void) canclBtnClickwithVc:(UIViewController *)vc
{
    //失败切换根视图控制器
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[LoginViewController alloc] init];
//    loginAppViewController *logInVC = [[loginAppViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:logInVC];
//    [vc presentViewController:navi animated:YES completion:nil];
}




#pragma mark --  AFNetWorking post请求上传图片   -----
+ (void)postRequestWithURL: (NSString *)url  //
                     image: (UIImage *)image  //  上传图片对象
               picFileName: (NSString *)picFileName//随机生成的文件名
                     block: (void(^)(NSDictionary *dict))dic
{
    //根据url初始化request
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"image/png", @"application/octet-stream", @"text/json",@"multipart/form-data",  nil];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"farm/ios %@" ,[userInfoDataModel shareduserInfoDataModel].versionNumStr] forHTTPHeaderField:@"User-Agent"];
    NSString *urls = [NSString stringWithFormat:@"http://ceshi-ucenter.hfgld.net/%@",url];
    [manager POST:urls parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData* data;
        NSData *newData;
        NSString *type;
        if(image){
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(image)) {
                //返回为png图像。
                data = UIImagePNGRepresentation(image);
                newData = data;
                type = @".png";
            }else {
                //返回为JPEG图像。
                data = UIImageJPEGRepresentation(image, 1.f);
//                CGFloat size = 2048.f;// kb
                CGFloat size = 100.f;
                CGFloat scale = size/(data.length/1024);
                newData= UIImageJPEGRepresentation(image, scale);
                type = @".jpeg";
            }
        }
        
        
        
        NSString *encodedImageStr = [newData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        
        
        NSLog(@"encodedImageStr==%@",encodedImageStr);
        
        //Base64字符串转UIImage图片：
        
//        NSData *decodedImageData = [[NSData alloc]
//
//                                    initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//
//        UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
//
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 400)];
//
//        [imgView setImage:decodedImage];
//
//        [self.view addSubview:imgView];
        
//        NSLog(@"decodedImage==%@",decodedImageData);
        
        
        
        
        
        
        
        
        [formData appendPartWithFileData:data
                                    name:@"uploadedfile"
                                    fileName:[NSString stringWithFormat:@"%@%@",picFileName,type]
                                    mimeType:@"image/png"];
        NSLog(@"%@" , [NSString stringWithFormat:@"%@%@",picFileName , type]);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"进度---%@" , uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[NSString stringWithFormat:@"%@" , responseObject[@"code"]] isEqualToString:@"1" ]) {
            NSLog(@"%@",responseObject[@"msg"]);
            dic(responseObject);
        }
        else if ([[NSString stringWithFormat:@"%@" , responseObject[@"code"]] isEqualToString:@"0" ])
        {
//            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"msg"] preferredStyle:(UIAlertControllerStyleAlert)];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [networkingManagerTool canclBtnClick];
            }]];
            //再不是控制器的类里面模态出提示框的方法
            UIWindow *window = nil;
            id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
            if ([delegate respondsToSelector:@selector(window)]) {
                window = [delegate performSelector:@selector(window)];
            } else {
                window = [[UIApplication sharedApplication] keyWindow];
            }
            [window.rootViewController presentViewController:alert animated:YES completion:nil];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@" , error.userInfo);
        [[networkingManagerTool sharedFMDBManager] getDataAnalysisWith:error.userInfo[@"com.alamofire.serialization.response.error.data"] withresultBlock:^(BOOL result, id value) {
            dic (value);
        } withvc:nil];
    
        
    }];
}





+ (void) canclBtnClick
{
    //失败切换根视图控制器
   
    
}


- (void) getCookies
{
    
}
- (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *application = [UIApplication sharedApplication];
    
    NSArray *children;
    if
        ([[application valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
            
            children = [[[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
            
        } else
        {
            
            children = [[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
            
        }
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

+ (void)cancleRequestData{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //终止所有下载任务
//    [manager.operationQueue cancelAllOperations];
    
//    //获取当前下载任务
//    NSOperation *operation = manager.operationQueue.operations.lastObject;
//    [operation cancel];
//
//    NSURLSessionDataTask *dataTask;
//    [dataTask cancel];
}
//取消所有网络请求





@end
