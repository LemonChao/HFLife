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
@end

NS_ASSUME_NONNULL_END
