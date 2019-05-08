//
//  UIView+Shadow.h
//  GDP
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)
-(void)addShadow;
- (void)addShadowColor:(UIColor *)color;
-(void)addShadowColor:(UIColor *)color offset:(CGSize)offset shadowRadius:(CGFloat)radius;

/**
 添加阴影圆角

 @param color <#color description#>
 @param offset <#offset description#>
 @param radius <#radius description#>
 @param opacity <#opacity description#>
 */
- (void)addShadowForViewColor:(UIColor *)color offSet:(CGSize)offset shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius  opacity:(CGFloat) opacity;
@end
