//
//  LYDataCache.h
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDataCache : NSObject
+(instancetype)getInstance;

/**
 缓存数据
 
 @param url 网络数据url
 @param jsonDict 请求成功后返回的数据
 @return 是否存储成功
 */
+(BOOL)saveDataUrl:(NSString *)url jsonDict:(NSDictionary *)jsonDict;

/**
 获取缓存的数据
 
 @param url 网络数据url
 @return 缓存的数据
 */
+(NSDictionary *)getData:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
