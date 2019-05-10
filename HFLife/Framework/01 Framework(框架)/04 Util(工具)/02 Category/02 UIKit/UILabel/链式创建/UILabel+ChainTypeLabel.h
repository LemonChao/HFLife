//
//  UILabel+ChainTypeLabel.h
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ChainTypeLabel)
+ (UILabel *(^)(void))creat;
- (UILabel *(^)(NSString *text))setText;
- (UILabel *(^)(UIColor *color))setTextColor;
- (UILabel *(^)(UIFont *font))setFont;
- (UILabel *(^)(CGFloat fontSize))setFontSize;
- (UILabel *(^)(NSTextAlignment textAlignment))setTextAligement;

- (UILabel *(^)(CGRect frame))setFrame;
- (UILabel *(^)(CGRect bounce))setBounce;
- (UILabel *(^)(UIColor *color))setBackgroundColor;
- (UILabel *(^)(CGFloat cornerRadius))setCornerRadius;
- (UILabel *(^)(CGFloat boardWidth))setBoardWidth;
- (UILabel *(^)(UIColor *boardColor))setBoardColor;
@end

NS_ASSUME_NONNULL_END
