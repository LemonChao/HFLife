

#import <Foundation/Foundation.h>

//请求类型（预留）
typedef NS_ENUM(NSUInteger, HRRequestType) {
    HRRequestModeHttp, //短链接
    HRRequestModeSocket, //长链接
};
//请求方式（预留）
typedef NS_ENUM(NSUInteger, HRHttpRequestWay) {
    HRHttpRequestWayAsync, //异步
    HRHttpRequestWaySync, //同步
};
//请求方法
typedef NS_ENUM(NSUInteger, HRHttpRequestMethod) {
    HRHttpRequestMethodGet, //GET
    HRHttpRequestMethodPost, //POST
    HRHttpRequestMethodForm, //表单
    HRHttpRequestMethodUpdate,//上传
    HRHttpRequestMethodDownLoad//上传
};

//上传方式



//请求加解密类型（预留）
typedef NS_ENUM(NSInteger, HRRequestCryptType) {
    HRRequestCryptTypeNone, //不进行加解密
};

//网络状态值
typedef NS_ENUM(NSUInteger, HRNetStatus) {
    HRNetStatusNotMoniter       = -2,   //未开始监测
    HRNetStatusUnknown          = -1,   //未知
    HRNetStatusNotReachable     = 0,    //无网络
    HRNetStatusCellular         = 1,    //蜂窝
    HRNetStatusWiFi             = 2,    //WiFi
};

@interface HRBaseRequest : NSObject

//0.1 请求类型
@property (assign, nonatomic) HRRequestType requestType;
//0.2 请求方式
@property (assign, nonatomic) HRHttpRequestWay requestWay;
//0.3 请求方法
@property (assign, nonatomic) HRHttpRequestMethod requestMethod;
//0.4 请求地址
@property (copy, nonatomic) NSString *requestUrl;
//0.5请求参数
@property (strong, nonatomic) NSDictionary *requestParams;
//0.6 请求超时时间
@property (assign, nonatomic) NSTimeInterval requestTimeOut;
//0.7 请求加密方式
@property (assign, nonatomic) HRRequestCryptType requestCryptType;

//1.0 发送请求
- (void)requestProgress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//2.1 进度回调
@property (copy, nonatomic) void(^progressBlock)(NSProgress *progress);
//2.2 错误信息
@property (strong, nonatomic, readonly) NSError *error;

//3.1 网络状态
@property (assign, nonatomic) HRNetStatus netStatus;

//4.1 是否显示打印信息
@property (assign, nonatomic) BOOL showLog;


@end
