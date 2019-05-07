
@interface NSString (JQAttributeString)


/**
 改变文本颜色（仅把文本中数字改变成不同颜色）

 @param param 需要变换的文本
 @param changeColor 需改变的颜色
 @param font 文本大小
 @return <#return value description#>
 */
+ (NSAttributedString *)getattarbuteStringWithDifferentColor:(NSString *)param changeColor:(UIColor *)changeColor font:(UIFont *)font;


//文本添加中划线
+ (NSAttributedString *)addmiddleLineAtText:(NSString *)param;

//文本添加下划线
+ (NSAttributedString *)addUnderLineAtText:(NSString *)param;


/*
 * 生成GUID 生成随机数
 */
+ (NSString *)generateUuidString;

@end
