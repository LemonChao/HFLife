//
//  UIView+cornerRadius.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "UIView+cornerRadius.h"

@implementation UIView (cornerRadius)
- (void)addCornerRadiusRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds   byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
