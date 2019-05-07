//
//  UIColor+Hex.h
//  HRFramework
//
//  Created by Yonggui Wang on 2018/6/12.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

@interface UIColor (Hex)


/**
 从十六进制字符串获取颜色

 @param color 十六进制字符串，支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @return 对应颜色值
 */
+ (UIColor *)colorWithHexString:(NSString *)color;


/**
 从十六进制字符串获取颜色，并设置透明度

 @param color 十六进制字符串，支持格式同上
 @param alpha 透明度
 @return 对应颜色值
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
