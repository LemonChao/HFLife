//
//  networkingManagerTool.h
//  门口农场
//
//  Created by SXF on 16/9/8.
//  Copyright © 2016年 Consequently there door. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    resultTypeError,
    resultTypeOk,
    
}resultType;

static  NSString *GET      = @"GET";
static  NSString *POST     = @"POST";
static  NSString *PUT      = @"PUT";
static  NSString *UPDATE   = @"UPDATE";
static  NSString *DOWNLOAD = @"DOWNLOAD";

//回传验证码图片
typedef void(^imageBlock)(UIImage *image);
//封装请求 返回值block
typedef void(^ValueBlock)(BOOL result , id value);

//2.1 进度回调
typedef void(^progressBlock)(NSProgress *progress);


@interface networkingManagerTool : NSObject
//创建单例
+ (networkingManagerTool *)sharedFMDBManager;


//发送请求  获得验证码图片数据
+(void)getAuthCodeWithBlock:(imageBlock)block;





/**
 +++++++++++++不带VC
 */
+ (void) requestToServerWithType:(NSString *)RequestType withSubUrl:(NSString *)subUrl withParameters:(NSDictionary *)parameters withResultBlock:(ValueBlock)valueBlock;



/**
 -------------带有进度条的请求
 */
+ (void) requestToServerWithType:(NSString *)RequestType withSubUrl:(NSString *)subUrl withParameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *progress))progress withResultBlock:(ValueBlock)valueBlock witnVC:(UIViewController *)VC;
/**
 +++++++++++++不带进度条的请求
 */
+ (void) requestToServerWithType:(NSString *)RequestType withSubUrl:(NSString *)subUrl withParameters:(NSDictionary *)parameters withResultBlock:(ValueBlock)valueBlock witnVC:(UIViewController *)VC;


//上传图片
+ (void)upLoadImageWithBase64WithImage:(UIImage *)image withSubUrl:(NSString *)subUrl progress:(progressBlock)progress withResultBlock:(void(^)(BOOL result , id  value)) resultBlock witnVC:(UIViewController *)VC;

//上传图片
+ (void)postRequestWithURL: (NSString *)url  //
                     image: (UIImage *)image  //  上传图片对象
               picFileName: (NSString *)picFileName//随机生成的文件名
                     block:(void(^)(NSDictionary *dict))resultBlock;
@end
