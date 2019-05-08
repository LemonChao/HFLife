//
//  HR_dataManagerTool.m
//  HRFramework
//
//  Created by mini on 2018/3/8.
//

#import "HR_dataManagerTool.h"

@implementation HR_dataManagerTool




//data转json需要转码
+ (NSDictionary *)GBKToUTF_8:(id)data {
    NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str=[[NSMutableString alloc] initWithData:data encoding:enc];
    NSData *JSONData = [str dataUsingEncoding:enc];
    
    NSDictionary *dictionary = [HR_dataManagerTool checkJsonWithJsonData:JSONData withEcodingStr:str];
    
    return dictionary;
}

//data转json不需要字符
+ (NSDictionary *)dataToJson:(id)data {
    //如果返回的是字典 那么就直接返回
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    NSString *str=[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *JSONData = [str dataUsingEncoding:NSUTF8StringEncoding];

    NSDictionary *dictionary = [HR_dataManagerTool checkJsonWithJsonData:JSONData withEcodingStr:str];
    
    return dictionary;
}

//data转json 这个方法对于有加密的参数 需进行解密
+ (NSDictionary *)dataToypteDJson:(id)data {
    //如果返回的是字典 那么就直接返回
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    NSString *str=[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (str.length == 0)
    {
        NSLog(@"数据返回错误");
        return nil;
    }
    //解密 这里如果返回数据不加密的话 就不用写
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSData *JSONData = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dictionary = [HR_dataManagerTool checkJsonWithJsonData:JSONData withEcodingStr:decodedString];
    
    return dictionary;
}
/*去掉json字符串中的特殊字符*/
+ (NSDictionary *)checkJsonWithJsonData:(NSData *)jsonData withEcodingStr:(NSString *)ecodingStr{
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    if (dictionary == nil) {
        ecodingStr = [ecodingStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        ecodingStr = [ecodingStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ecodingStr = [ecodingStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *JSONData = [ecodingStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        return dictionary;
    }
    
    return dictionary;
}














//解析字典数据
+ (id)getRecordMsgWithDic:(NSDictionary *)dic withClass:(Class)recordClass{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:dic];
    for (NSString *key in dictM.allKeys) {
        //取到值 如果是<NULL>那么就赋值为空
        if ([dictM[key] isKindOfClass:[NSNull class]] || dictM[key] == [NSNull null]) {
            [dictM setValue:@"" forKey:key];
            NSLog(@"发现值为空%@",  dic[key]);
            NSLog(@"发现值为空的key：%@---已经将值改变为%@", key , dictM[key]);
        }
    }
    id class = [recordClass new];
    [class setValuesForKeysWithDictionary:dictM];
    return class;
}

//解析列表（数组）数据
+ (NSArray *)getTheRecordMsgWithArr:(NSArray *)dataArr withClass:(Class)recordClass
{
    NSMutableArray *recordArr = [NSMutableArray array];
    NSLog(@"列表数据------%@" , dataArr);
    for (NSMutableDictionary *subDic in dataArr)
    {
        if (![subDic isKindOfClass:[NSDictionary class]]) {
            //防止不是字典
            NSLog(@"");
            continue;
        }
        for (NSString *key in subDic.allKeys) {
            //取到值 如果是<NULL>那么就赋值为空
            //保证字典为可变的
            if ([subDic[key] isKindOfClass:[NSNull class]] || subDic[key] == [NSNull null]) {
                [subDic setValue:@"-----" forKey:key];
                NSLog(@"发现值为空%@",  subDic[key]);
                NSLog(@"发现值为空的key：%@---已经将值改变为%@", key , subDic[key]);
            }
        }
        id class = [recordClass new];
        [class setValuesForKeysWithDictionary:subDic];
        [recordArr addObject:class];
    }
    return [recordArr copy];
}


@end
