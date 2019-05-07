//
//  LYDataCache.m
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LYDataCache.h"

@implementation LYDataCache
//缓存数据
+(BOOL)saveDataUrl:(NSString *)url jsonDict:(NSDictionary *)jsonDict{
    NSString *configFile = [self getPath:url];
    BOOL isSucces = [jsonDict writeToFile:configFile atomically:YES];
    return isSucces;
}
//获取缓存的数据
+(NSDictionary *)getData:(NSString *)url{
    NSString *configFile = [self getPath:url];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:configFile];
    return dict;
}

//生成文件路径
+(NSString *)getPath:(NSString *)url{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    NSString *pathDocuments = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *createPath = [pathDocuments stringByAppendingPathComponent:@"UserData"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //创建文件
    NSString *tempStrUrl = [url stringByReplacingOccurrencesOfString:@"." withString:@""];//去掉“”
    tempStrUrl = [tempStrUrl stringByReplacingOccurrencesOfString:@"/" withString:@""];//去掉"/"
    NSString *configFile = [createPath stringByAppendingPathComponent:tempStrUrl];
    return configFile;
}
@end
