//
//  UIImage+Developer.h
//  SDFastSendUser
//
//  Created by mac on 2017/8/26.
//  Copyright © 2017年 SDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Developer)
/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 生成条形码

 @param content 内容
 @param size 大小
 @param red <#red description#>
 @param green <#green description#>
 @param blue <#blue description#>
 @return <#return value description#>
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content
                       codeImageSize:(CGSize)size
                                 red:(CGFloat)red
                               green:(CGFloat)green
                                blue:(NSInteger)blue;
//+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size;
@end
