//
//  HR_dataManagerTool.h
//  HRFramework
//
//  Created by mini on 2018/3/8.
//

#import <Foundation/Foundation.h>

@interface HR_dataManagerTool : NSObject

/**
 data转json需要转码
 */
+ (NSDictionary *)GBKToUTF_8:(id)data;


/**
 data转json不需要字符
 */
+ (NSDictionary *)dataToJson:(id)data;


/**
 data转json 这个方法对于有加密的参数 需进行解密
 */
+ (NSDictionary *)dataToypteDJson:(id)data;


/**解析（字典）数据*/
+ (id)getRecordMsgWithDic:(NSDictionary *)dic withClass:(Class)recordClass;

/**解析列表数据*/
+ (NSArray *)getModelArrWithArr:(NSArray *)dataArr withClass:(Class)recordClass;
@end
