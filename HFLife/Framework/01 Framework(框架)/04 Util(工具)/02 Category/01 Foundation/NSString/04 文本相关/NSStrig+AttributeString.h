
@interface NSString (AttributeString)


/**
 改变文本颜色（仅把文本中数字改变成不同颜色）

 @param param 需要变换的文本
 @param changeColor 需改变的颜色
 @param font 文本大小
 @return <#return value description#>
 */
+ (NSAttributedString *)getattarbuteStringWithDifferentColor:(NSString *)param changeColor:(UIColor *)changeColor font:(UIFont *)font;



/**
 文本添加中划线

 @param param <#param description#>
 @return <#return value description#>
 */
+ (NSAttributedString *)addmiddleLineAtText:(NSString *)param;
/**
 文本指定位置添加中划线
 
 @param param <#param description#>
 @return <#return value description#>
 */
+(NSAttributedString *)addUnderLineAtText:(NSString *)param range:(NSRange)range;

/**
 文本添加下划线

 @param param <#param description#>
 @return <#return value description#>
 */
+ (NSAttributedString *)addUnderLineAtText:(NSString *)param;

/**
 文本指定位置添加下划线
 
 @param param <#param description#>
 @return <#return value description#>
 */
+(NSAttributedString *)addmiddleLineAtText:(NSString *)param range:(NSRange)range;


/**
 特殊字符串

 @param font <#font description#>
 @param color <#color description#>
 @param range <#range description#>
 @return <#return value description#>
 */
- (NSAttributedString *)setAtrbiuteStringWithFont:(UIFont *)font
                                            color:(UIColor *)color
                                            range:(NSRange)range;


/**
 计算行高
*/
- (CGSize)getSizeWithFount:(UIFont *)font andMaxSize:(CGSize)size;

/**拼接特殊字体字符串支持前中后
 注意 ： 数组中前面是 UIColor， 后面是UIFont
 
 */
+ (NSAttributedString *)atributeStrFrontStr:(NSString *)frontStr
                               colorAndFont:(NSArray *)frontStrAtribute
                                  middleStr:(NSString *)frontStr
                               colorAndFont:(NSArray *)MiddleStrAtribute
                                  behindStr:(NSString *)frontStr
                               colorAndFont:(NSArray *)behindStrAtribute withView:(UIView *)lableOrOther;

+ (NSAttributedString *)atributeStrFrontStr:(NSString *) frontStr colorAndFont:(NSArray *)frontStrAtribute middleStr:(NSString *)middleStr colorAndFont:(NSArray *)middleStrAtribute behindStr:(NSString *)behindStr colorAndFont:(NSArray *)behindStrAtribute withView:(UIView *)lableOrOther fontName:(NSDictionary *)fontNameDict;













/*
 * 生成GUID 生成随机数
 */
+ (NSString *)generateUuidString;

@end
