//
//  UIImageView+ChainTypeImageView.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ChainTypeImageView)

- (UIImageView *(^)(UIImage *image))setImage;
- (UIImageView *(^)(UIViewContentMode contentMode))setImgContentMode;
- (UIImageView *(^)(CGRect frame))setFrame;
- (UIImageView *(^)(CGRect bounce))setBounce;
- (UIImageView *(^)(UIColor *color))setBackgroundColor;
- (UIImageView *(^)(CGFloat cornerRadius))setCornerRadius;
- (UIImageView *(^)(CGFloat boardWidth))setBoardWidth;
- (UIImageView *(^)(UIColor *boardColor))setBoardColor;

@end

NS_ASSUME_NONNULL_END
