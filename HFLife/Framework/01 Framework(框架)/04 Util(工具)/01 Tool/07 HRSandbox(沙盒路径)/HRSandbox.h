

#import <Foundation/Foundation.h>

@interface HRSandbox : NSObject

//1.0 document  itunes会备份，存储非常重要的文件
+ (NSString *)docPath;

//1.1 prefrence 保存程序的设置信息，itunes会备份
+ (NSString *)libPrePath;

//1.2 cache 保存程序的缓存信息，itunes不会备份
+ (NSString *)libCachePath;

//1.3 tmp 存储数据较大的临时文件，程序重新启动会清除这个文件夹里的所有内容
+ (NSString *)tmpPath;

@end
