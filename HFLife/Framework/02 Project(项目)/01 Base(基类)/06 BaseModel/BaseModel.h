//
//  BaseModel.h
//  ShanDianPaoTui
//
//  Created by mac on 2017/8/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Extension.h"
@interface BaseModel : NSObject<NSCoding, NSCopying>
/**
 *  初始化方法
 *
 *  @param dict 一个字典，字典里的key是model的属性名字，value是该属性对应的值
 *
 *  @return 返回对象
 */
- (id)init:(NSDictionary *)dict;

/**
 json格式字符串转字典

 @param jsonString json格式字符串
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;

/**
 字典转json字符串

 @param dict json格式字符串
 @return 返回字符串
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
@end
