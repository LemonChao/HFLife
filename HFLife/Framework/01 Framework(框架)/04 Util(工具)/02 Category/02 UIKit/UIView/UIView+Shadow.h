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
-(void)addShadowColor:(UIColor *)color offset:(CGSize)offsert;
@end
