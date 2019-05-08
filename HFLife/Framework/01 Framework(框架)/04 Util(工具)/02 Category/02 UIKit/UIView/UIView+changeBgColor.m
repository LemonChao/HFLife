//
//  UIView+changeBgColor.m
//  DoLifeApp
//
//  Created by sxf_pro on 2018/6/16.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import "UIView+changeBgColor.h"

@implementation UIView (changeBgColor)

- (void) changeBgViewWith:(NSArray<UIColor *>*)colors{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)colors[0].CGColor, (__bridge id)colors[1].CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
}


- (void) changeBgViewUpDownWith:(NSArray<UIColor *>*)colors{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)colors[0].CGColor, (__bridge id)colors[1].CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    
}
- (void) changeBgView:(NSArray<UIColor *>*)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)colors[0].CGColor, (__bridge id)colors[1].CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
}
@end
