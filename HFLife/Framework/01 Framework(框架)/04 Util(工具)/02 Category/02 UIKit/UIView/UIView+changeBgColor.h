//
//  UIView+changeBgColor.h
//  DoLifeApp
//
//  Created by sxf_pro on 2018/6/16.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (changeBgColor)
- (void) changeBgViewWith:(NSArray<UIColor *>*)colors;
/**
 上下渐变
 */
- (void) changeBgViewUpDownWith:(NSArray<UIColor *>*)colors;


/**
 设置渐变色

 @param colors <#colors description#>
 @param startPoint <#startPoint description#>
 @param endPoint <#endPoint description#>
 */
- (void) changeBgView:(NSArray<UIColor *>*)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
