//
//  UIButton+EdgeInsets.h
//  MyTabBarCustom
//
//  Created by shen on 2017/5/11.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePositionType) {
    ImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    ImagePositionTypeRight,  //图片在右，标题在左
    ImagePositionTypeTop,    //图片在上，标题在下
    ImagePositionTypeBottom  //图片在下，标题在上
};

/**
 默认情况下，imageEdgeInsets和titleEdgeInsets都是0。先不考虑height,
 
 if (button.width小于imageView上image的width){图像会被压缩，文字不显示}
 
 if (button.width < imageView.width + label.width){图像正常显示，文字显示不全}
 
 if (button.width >＝ imageView.width + label.width){图像和文字都居中显示，imageView在左，label在右，中间没有空隙}
 */
@interface UIButton (EdgeInsets)
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
 2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param postion    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */

- (void)setImagePosition:(ImagePositionType)postion spacing:(CGFloat)spacing;

/**
 根据图文距button边框的距离 自动调整图文水平间距,

 @param postion 图片位置类型
 @param margin 图片、文字离button边框的距离
 */
- (void)setImagePosition:(ImagePositionType)postion WithMargin:(CGFloat )margin;



/**
 商城tabBar上的plusButton 图文排版

 @param postion 图片位置
 @param spacing 图文间距
 */
- (void)tabBarItem_setImagePosition:(ImagePositionType)postion spacing:(CGFloat)spacing;


@end
