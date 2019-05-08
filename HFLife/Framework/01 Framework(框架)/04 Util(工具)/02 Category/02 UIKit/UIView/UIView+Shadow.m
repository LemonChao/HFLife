//
//  UIView+Shadow.m
//  GDP
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)
-(void)addShadow{
    [self addShadowColor:[UIColor blackColor] offset:CGSizeMake(0, 2) shadowRadius:2];
}


- (void)addShadowColor:(UIColor *)color
{
    [self addShadowColor:color offset:CGSizeMake(0, 7) shadowRadius:2];
}

-(void)addShadowColor:(UIColor *)color offset:(CGSize)offset shadowRadius:(CGFloat) radius
{
    UIView * shadowView= [[UIView alloc] init];
    shadowView.backgroundColor = [UIColor whiteColor];
    // 禁止将 AutoresizingMask 转换为 Constraints
    shadowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.superview insertSubview:shadowView belowSubview:self];
    // 添加 right 约束
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:shadowView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.superview addConstraint:rightConstraint];
    
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:shadowView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.superview addConstraint:leftConstraint];
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:shadowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.superview addConstraint:topConstraint];
    // 添加 bottom 约束
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:shadowView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.superview addConstraint:bottomConstraint];
    shadowView.layer.shadowColor = color.CGColor;
    shadowView.layer.shadowOffset = offset;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowRadius = radius;
    shadowView.clipsToBounds = NO;
    
}


- (void)addShadowForViewColor:(UIColor *)color offSet:(CGSize)offset shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius  opacity:(CGFloat) opacity{
//    self.layer.shadowColor = color.CGColor;
//    self.layer.shadowRadius = shadowRadius;
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = offset;
//    self.layer.cornerRadius = cornerRadius;
//    self.layer.masksToBounds = NO;
//    self.clipsToBounds = YES;
//    
    
    
    self.layer.shadowColor = color.CGColor;;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    self.masksToBounds = NO;
    
    
}
@end
