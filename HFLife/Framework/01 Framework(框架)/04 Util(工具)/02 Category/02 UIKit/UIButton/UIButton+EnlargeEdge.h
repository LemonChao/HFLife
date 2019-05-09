//
//  UIButton+EnlargeEdge.h
//  DD_RedPaket
//
//  Created by sxf_pro on 2018/6/8.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (EnlargeEdge)

/** 设置可点击范围到按钮边缘的距离 */
- (void)setEnlargeEdge:(CGFloat)size;

/** 设置可点击范围到按钮上、右、下、左的距离 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
