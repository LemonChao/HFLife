//
//  UIView+cornerRadius.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (cornerRadius)
//添加圆角
- (void)addCornerRadiusRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
@end

NS_ASSUME_NONNULL_END
