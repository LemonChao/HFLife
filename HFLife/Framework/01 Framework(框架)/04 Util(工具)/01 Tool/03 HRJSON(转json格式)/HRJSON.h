

#import <Foundation/Foundation.h>

@interface HRJSON : NSObject

//1.0 对象转jsonData(只支持数组和字典)
+ (NSData *)JSONData:(id)obj;

//1.1 对象转jsonString(只支持数组和字典)
+ (NSString *)JSONString:(id)obj;

@end
