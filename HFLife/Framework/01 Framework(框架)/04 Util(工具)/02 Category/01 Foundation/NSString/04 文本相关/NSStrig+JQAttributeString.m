
#import "NSStrig+JQAttributeString.h"

@implementation NSString (JQAttributeString)

+ (NSAttributedString *)getattarbuteStringWithDifferentColor:(NSString *)param changeColor:(UIColor *)changeColor font:(UIFont *)font
{
    @try {
        NSString *content = param;
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:content];
        
        for (int i = 0; i < content.length; i ++) {
            NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
            if ([number containsObject:a]) {
                [attributeString setAttributes:@{NSForegroundColorAttributeName:changeColor,NSFontAttributeName:font,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
            }
        }
    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
    }
}

+(NSAttributedString *)addmiddleLineAtText:(NSString *)param{

    @try {
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:param attributes:attribtDic];
        return attribtStr;
    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
    }
}


+(NSAttributedString *)addUnderLineAtText:(NSString *)param
{
    
    @try {
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:param attributes:attribtDic];
        return attribtStr;
    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
        
    }
}


/*
 * 生成GUID 生成随机数
 */
+ (NSString *)generateUuidString{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // transfer ownership of the string
    // to the autorelease pool
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

@end
