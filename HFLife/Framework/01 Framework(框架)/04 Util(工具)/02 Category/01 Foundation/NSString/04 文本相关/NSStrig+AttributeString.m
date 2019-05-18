
#import "NSStrig+AttributeString.h"

@implementation NSString (AttributeString)

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


+(NSAttributedString *)addmiddleLineAtText:(NSString *)param range:(NSRange)range{
    
    NSString *textStr = param;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    
    [attribtStr setAttributes:attribtDic range:range];
    
    // 赋值
    return attribtStr;
}






+(NSAttributedString *)addUnderLineAtText:(NSString *)param range:(NSRange)range{
    NSString *textStr = param;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    
    [attribtStr setAttributes:attribtDic range:range];
    
    // 赋值
    return attribtStr;
}




- (NSAttributedString *)setAtrbiuteStringWithFont:(UIFont *)font
                                            color:(UIColor *)color
                                            range:(NSRange)range{
    NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *strAtrbiute = @{NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : color,
                                  };
    [atrStr setAttributes:strAtrbiute range:range];
    return atrStr;
}



/**
 *  类方法计算size大小
 */
- (CGSize)getSizeWithFount:(UIFont *)font andMaxSize:(CGSize)size
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



//拼接特殊字符串 支持前， 中， 后
+ (NSAttributedString *)atributeStrFrontStr:(NSString *) frontStr colorAndFont:(NSArray *)frontStrAtribute middleStr:(NSString *)middleStr colorAndFont:(NSArray *)middleStrAtribute behindStr:(NSString *)behindStr colorAndFont:(NSArray *)behindStrAtribute withView:(UIView *)lableOrOther{
    //设置默认
    NSArray *defaulteStrAtrbuteArr;
    if ([lableOrOther isKindOfClass:[UILabel class]]) {
        UILabel *l = (UILabel *)lableOrOther;
        defaulteStrAtrbuteArr = @[l.textColor, l.font];
    }else if ([lableOrOther isKindOfClass:[UITextView class]]) {
        UITextView *t = (UITextView *)lableOrOther;
        defaulteStrAtrbuteArr = @[t.textColor, t.font];
    }else if ([lableOrOther isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField *)lableOrOther;
        defaulteStrAtrbuteArr = @[tf.textColor, tf.font];
    }else{
        
    }
    //设置默认
    
    NSString *defauleStr = @"";
    if (frontStr.length == 0) {
        frontStr = defauleStr;
    }
    if (frontStrAtribute.count != 2 || !([frontStrAtribute[0] isKindOfClass:[UIColor class]] && [frontStrAtribute[1] isKindOfClass:[UIFont class]])){
        frontStrAtribute = defaulteStrAtrbuteArr;
    }
    
    if (middleStr.length == 0 ) {
        middleStr = defauleStr;
    }
    if (middleStrAtribute.count != 2 || !([middleStrAtribute[0] isKindOfClass:[UIColor class]] && [middleStrAtribute[1] isKindOfClass:[UIFont class]])){
        middleStrAtribute = defaulteStrAtrbuteArr;
    }
    
    if (behindStr.length == 0) {
        behindStr = defauleStr;
    }
    if (behindStrAtribute.count != 2 || !([behindStrAtribute[0] isKindOfClass:[UIColor class]] && [behindStrAtribute[1] isKindOfClass:[UIFont class]])){
        behindStrAtribute = defaulteStrAtrbuteArr;
    }
    NSDictionary *frontStrMAtribute = @{NSForegroundColorAttributeName : frontStrAtribute[0], NSFontAttributeName : frontStrAtribute[1]};
    
    NSDictionary *middleStrMMAtribute = @{NSForegroundColorAttributeName : middleStrAtribute[0], NSFontAttributeName : middleStrAtribute[1]};
    
    NSDictionary *behindStrMAtribute = @{NSForegroundColorAttributeName : behindStrAtribute[0], NSFontAttributeName : behindStrAtribute[1]};
    
    NSString *newStr;
    //    newStr = [NSString stringWithFormat:@"%@%@%@", frontStr, middleStr, behindStr];
    newStr = [[frontStr stringByAppendingString:middleStr] stringByAppendingString:behindStr];
    
    NSMutableAttributedString *newAtributeStrM = [[NSMutableAttributedString alloc] initWithString:newStr];
    
    [newAtributeStrM setAttributes:frontStrMAtribute range:NSMakeRange(0, frontStr.length)];
    
    [newAtributeStrM setAttributes:middleStrMMAtribute range:NSMakeRange(frontStr.length, middleStr.length)];
    
    [newAtributeStrM setAttributes:behindStrMAtribute range:NSMakeRange(frontStr.length + middleStr.length, behindStr.length)];
    
    return newAtributeStrM;
}


+ (NSAttributedString *)atributeStrFrontStr:(NSString *) frontStr colorAndFont:(NSArray *)frontStrAtribute middleStr:(NSString *)middleStr colorAndFont:(NSArray *)middleStrAtribute behindStr:(NSString *)behindStr colorAndFont:(NSArray *)behindStrAtribute withView:(UIView *)lableOrOther fontName:(NSDictionary *)fontNameDict{
    //设置默认
    NSArray *defaulteStrAtrbuteArr;
    if ([lableOrOther isKindOfClass:[UILabel class]]) {
        UILabel *l = (UILabel *)lableOrOther;
        defaulteStrAtrbuteArr = @[l.textColor, l.font];
    }else if ([lableOrOther isKindOfClass:[UITextView class]]) {
        UITextView *t = (UITextView *)lableOrOther;
        defaulteStrAtrbuteArr = @[t.textColor, t.font];
    }else if ([lableOrOther isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField *)lableOrOther;
        defaulteStrAtrbuteArr = @[tf.textColor, tf.font];
    }else{
        
    }
    //设置默认
    
    NSString *defauleStr = @"";
    if (frontStr.length == 0) {
        frontStr = defauleStr;
    }
    if (frontStrAtribute.count != 2 || !([frontStrAtribute[0] isKindOfClass:[UIColor class]] && [frontStrAtribute[1] isKindOfClass:[UIFont class]])){
        frontStrAtribute = defaulteStrAtrbuteArr;
    }
    
    if (middleStr.length == 0 ) {
        middleStr = defauleStr;
    }
    if (middleStrAtribute.count != 2 || !([middleStrAtribute[0] isKindOfClass:[UIColor class]] && [middleStrAtribute[1] isKindOfClass:[UIFont class]])){
        middleStrAtribute = defaulteStrAtrbuteArr;
    }
    
    if (behindStr.length == 0) {
        behindStr = defauleStr;
    }
    if (behindStrAtribute.count != 2 || !([behindStrAtribute[0] isKindOfClass:[UIColor class]] && [behindStrAtribute[1] isKindOfClass:[UIFont class]])){
        behindStrAtribute = defaulteStrAtrbuteArr;
    }
    NSDictionary *frontStrMAtribute = @{NSForegroundColorAttributeName : frontStrAtribute[0], NSFontAttributeName : frontStrAtribute[1]};
    
    NSDictionary *middleStrMMAtribute = @{NSForegroundColorAttributeName : middleStrAtribute[0], NSFontAttributeName : middleStrAtribute[1]};
    
    NSDictionary *behindStrMAtribute = @{NSForegroundColorAttributeName : behindStrAtribute[0], NSFontAttributeName : behindStrAtribute[1]};
    
    NSString *newStr;
    //    newStr = [NSString stringWithFormat:@"%@%@%@", frontStr, middleStr, behindStr];
    newStr = [[frontStr stringByAppendingString:middleStr] stringByAppendingString:behindStr];
    
    NSMutableAttributedString *newAtributeStrM = [[NSMutableAttributedString alloc] initWithString:newStr];
    
    [newAtributeStrM setAttributes:frontStrMAtribute range:NSMakeRange(0, frontStr.length)];
    
    [newAtributeStrM setAttributes:middleStrMMAtribute range:NSMakeRange(frontStr.length, middleStr.length)];
    
    [newAtributeStrM setAttributes:behindStrMAtribute range:NSMakeRange(frontStr.length + middleStr.length, behindStr.length)];
    
    return newAtributeStrM;
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
