//
//  UIButton+EdgeInsets.m
//  MyTabBarCustom
//
//  Created by shen on 2017/5/11.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "UIButton+EdgeInsets.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define _SINGLELINE_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define _SINGLELINE_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

@implementation UIButton (EdgeInsets)


- (void)setImagePosition:(ImagePositionType)postion spacing:(CGFloat)spacing {
    CGFloat imgW = self.imageView.image.size.width;
    CGFloat imgH = self.imageView.image.size.height;
    CGSize origLabSize = self.titleLabel.bounds.size;
    CGFloat orgLabW = origLabSize.width;
    CGFloat orgLabH = origLabSize.height;
    
    CGSize trueSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat trueLabW = trueSize.width;
    
//    self.imageView.backgroundColor = [UIColor yellowColor];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    
    //image中心移动的x距离
    CGFloat imageOffsetX = orgLabW/2 ;
    //image中心移动的y距离
    CGFloat imageOffsetY = orgLabH/2 + spacing/2;
    //label左边缘移动的x距离
    CGFloat labelOffsetX1 = imgW/2 - orgLabW/2 + trueLabW/2;
    //label右边缘移动的x距离
    CGFloat labelOffsetX2 = imgW/2 + orgLabW/2 - trueLabW/2;
    //label中心移动的y距离
    CGFloat labelOffsetY = imgH/2 + spacing/2;
    
    switch (postion) {
        case ImagePositionTypeLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case ImagePositionTypeRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, orgLabW + spacing/2, 0, -(orgLabW + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW + spacing/2), 0, imgW + spacing/2);
            break;
            
        case ImagePositionTypeTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX1, -labelOffsetY, labelOffsetX2);
            break;
            
        case ImagePositionTypeBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX1, labelOffsetY, labelOffsetX2);
            break;
            
        default:
            break;
    }
    
}




/**根据图文距边框的距离 自动调整图文间距*/
- (void)setImagePosition:(ImagePositionType)postion WithMargin:(CGFloat )margin {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat labelWidth = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    CGFloat spacing = self.bounds.size.width - imageWith - labelWidth - 2*margin;
    
    [self setImagePosition:postion spacing:spacing];
}

- (void)tabBarItem_setImagePosition:(ImagePositionType)postion spacing:(CGFloat)spacing {
    CGFloat bottomMargin = 0.f;
    CGFloat imgW = self.imageView.image.size.width;
    CGFloat imgH = self.imageView.image.size.height;//(4,10) 8,xr(11.5,13.5) plus,x,xs,xsmax,(11.3,13.3)
    CGSize origLabSize = IS_IPHONE_5 ? CGSizeMake(4, 10) : CGSizeMake(11.4, 13.4);
//    CGSize origLabSize = self.titleLabel.frame.size;
    CGFloat orgLabW = origLabSize.width;
    CGFloat orgLabH = origLabSize.height;

    CGSize trueSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat trueLabW = trueSize.width;
    //image中心移动的x距离
    CGFloat imageOffsetX = orgLabW/2 ;
    //image中心移动的y距离
    CGFloat imageOffsetY = imgH/2-self.bounds.size.height/2+orgLabH+spacing+bottomMargin;
    //label左边缘移动的x距离
    CGFloat labelOffsetX1 = imgW/2 - orgLabW/2 + trueLabW/2;
    //label右边缘移动的x距离
    CGFloat labelOffsetX2 = imgW/2 + orgLabW/2 - trueLabW/2;
    //label中心移动的y距离
    CGFloat labelOffsetY = orgLabH-self.bounds.size.height/2+bottomMargin;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY-10, imageOffsetX, imageOffsetY, -imageOffsetX);
    self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX1, labelOffsetY, labelOffsetX2);
}

@end
