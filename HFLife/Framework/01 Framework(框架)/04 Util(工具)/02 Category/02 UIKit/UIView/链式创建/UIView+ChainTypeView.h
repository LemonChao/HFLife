//
//  UIView+ChainTypeView.h
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ChainTypeView)
- (UIView *(^)(CGRect frame))setFrame;
- (UIView *(^)(CGRect bounce))setBounce;
- (UIView *(^)(UIColor *color))setBackgroundColor;
- (UIView *(^)(CGFloat cornerRadius))setCornerRadius;
- (UIView *(^)(CGFloat boardWidth))setBoardWidth;
- (UIView *(^)(UIColor *boardColor))setBoardColor;

@end

NS_ASSUME_NONNULL_END
