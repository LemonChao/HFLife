//
//  BaseModel.m
//  ShanDianPaoTui
//
//  Created by mac on 2017/8/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (id)init:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            for (NSString *name in self.properties)
            {
//                NSString *key = [name stringByReplacingOccurrencesOfString:@"_" withString:@""];
                 NSString *key = name;
                if ([dict[key] isKindOfClass:[NSString class]])
                {
                    NSString *str =(NSString *)dict[key];
                    if (str == nil || str.length == 0)
                    {
                        str = @"";
                    }
                    [self setValue:str forKey:name];
                }
                else if ([dict[key] isKindOfClass:[NSArray class]])
                {
                    NSArray *array =(NSArray *)dict[key];
                    if (array == nil)
                    {
                        array = [NSArray array];
                    }
                    [self setValue:array forKey:name];
                }else if ([dict[key] isKindOfClass:[NSNumber class]]){
                    if (dict[key] != nil) {
                        [self setValue:dict[key]  forKey:name];
                    }
                }else if ([dict[key] isKindOfClass:[NSDictionary class]]){
                    NSDictionary *dictonary =(NSDictionary *)dict[key];
                    if (dictonary == nil)
                    {
                        dictonary = [[NSDictionary alloc]init];
                    }
                    [self setValue:dictonary forKey:name];
                }
                
            }
        }
    }
    return self;
}
/**
 *  重写properties的get方法
 *
 *  @return 返回数组
 */
-(NSMutableArray *)properties
{
    NSMutableArray *array =[NSMutableArray array] ;
    unsigned int count;
    //获取属性列表//利用这个属性可以实现给Model类赋值(这里填的是[self superclass]而不是self，因为可能一个A继承BaseModel，而B继承A,这样会吧A里的属性取出来)
    objc_property_t * propertyList = class_copyPropertyList([[self superclass] class], &count);
    for (unsigned int i=0; i<count; i++)
    {
        const char * propertyname = property_getName(propertyList[i]);
        NSString *str = [NSString stringWithUTF8String:propertyname];
        [array addObject:str];
    }
    //把A里的属性和B里的属性全部放在一起
    for (int i = 0; i < super.properties.count; i++)
    {
        [array addObject:super.properties[i]];
    }
    return  array;
}
//json格式字符串转字典：

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
 
}
//字典转json字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"找不到的：key-%@=====value-%@" , key , value);
    if ([value isKindOfClass:[NSNull class]] || value == nil) {
        NSLog(@"！！！！！！！！！---------------------数据类型位---<Null>---value = %@" , value);
        //设置数据为@"";
        value = @"";
        [self setValue:value forKeyPath:key];
    }
    if ([key isEqualToString:@"description"]) {
        key = @"Mydescription";//
        [self setValue:value forKeyPath:@"Mydescription"];
    }
    if ([key isEqualToString:@"id"]) {
        key = @"ID";//小写id转大写ID
        [self setValue:value forKeyPath:@"ID"];
    } else {
        NSLog(@"您尝试设置的key：%@不存在",key);
        NSLog(@"您尝试设置的value：%@",value);
    }
}

/**
 归档解档
 */
// 解档
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        // 获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            // 进行解档取值
            id value = [decoder decodeObjectForKey:strName];
            // 利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}
// 归档
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        // 利用KVC取值
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

//log模型
-(NSString *)description
{
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i <count; i ++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";
        [jsonDic setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@:%p> -- %@",[self mj_keyValues],self,jsonDic];
}

-(NSString *)debugDescription
{
    return [NSString stringWithFormat:@"%@ -- %p",[self mj_keyValues],self];
}



@end
