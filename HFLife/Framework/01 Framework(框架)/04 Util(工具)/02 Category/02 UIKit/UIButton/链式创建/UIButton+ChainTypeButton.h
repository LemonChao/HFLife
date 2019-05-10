//
//  UIButton+ChainTypeButton.h
//  HFLife
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TouchedButtonCallback)(void);
@interface UIButton (ChainTypeButton)

- (UIButton *(^)(NSString *title, UIControlState state))setTitle;
- (UIButton *(^)(UIColor *color, UIControlState state))setTitleColor;
- (UIButton *(^)(UIImage *image, UIControlState state))setImage;
- (UIButton *(^)(UIImage *image, UIControlState state))setBackgroundImage;
- (UIButton *(^)(UIFont *font))setTitleFont;
- (UIButton *(^)(CGFloat fontSize))setTitleFontSize;
- (UIButton *(^)(TouchedButtonCallback touchHandler))addAction;

- (UIButton *(^)(CGRect frame))setFrame;
- (UIButton *(^)(CGRect bounce))setBounce;
- (UIButton *(^)(UIColor *color))setBackgroundColor;
- (UIButton *(^)(CGFloat cornerRadius))setCornerRadius;
- (UIButton *(^)(CGFloat boardWidth))setBoardWidth;
- (UIButton *(^)(UIColor *boardColor))setBoardColor;
@end

NS_ASSUME_NONNULL_END
