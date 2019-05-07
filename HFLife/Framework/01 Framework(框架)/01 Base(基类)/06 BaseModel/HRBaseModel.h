
/*
 基本模型类
 */

#import <Foundation/Foundation.h>

@interface HRBaseModel : NSObject

/**
 字典转模型

 @param dic 数据字典
 @return 模型
 */
-(id)initWithDictionary:(NSDictionary *)dic;

@end
