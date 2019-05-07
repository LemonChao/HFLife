
#import "HRJSON.h"

@implementation HRJSON
//1.0 对象转jsonData(只支持数组和字典)
+ (NSData *)JSONData:(id)obj {
    if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        if ([jsonData length] > 0 && error == nil){
            return jsonData;
        }
    }
    return nil;
}
//1.1 对象转jsonString(只支持数组和字典)
+ (NSString *)JSONString:(id)obj {
    NSData *jsonData = [HRJSON JSONData:obj];
    if (jsonData.length) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}

@end
