//
//  UITextField+ChainTypeTextField.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ChainTypeTextField)

- (UITextField *(^)(NSString *text))setText;
- (UITextField *(^)(UIColor *color))setTextColor;
- (UITextField *(^)(UIFont *font))setFont;
- (UITextField *(^)(CGFloat fontSize))setFontSize;
- (UITextField *(^)(NSTextAlignment textAlignment))setTextAligement;
- (UITextField *(^)(NSString *placeHolder))setPlaceHolder;
- (UITextField *(^)(UIColor *color))setPlaceholderColor;
- (UITextField *(^)(UIFont *font))setPlaceholderFont;
- (UITextField *(^)(CGRect frame))setFrame;
- (UITextField *(^)(CGRect bounce))setBounce;
- (UITextField *(^)(UIColor *color))setBackgroundColor;
- (UITextField *(^)(CGFloat cornerRadius))setCornerRadius;
- (UITextField *(^)(CGFloat boardWidth))setBoardWidth;
- (UITextField *(^)(UIColor *boardColor))setBoardColor;
@end

NS_ASSUME_NONNULL_END
