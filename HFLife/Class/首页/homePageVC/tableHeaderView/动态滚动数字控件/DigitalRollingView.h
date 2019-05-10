//
//  DigitalRollingView.h
//  数字滚动
//
//  Created by sxf on 2019/1/2.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DigitalRollingView : UIView
// 内容相关
@property (nonatomic, assign) double number;
// 内容相关
@property (nonatomic, assign) int integerNumber;
// 样式相关
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSUInteger density;               // 滚动数字的密度
@property (nonatomic, assign) NSUInteger minLength;             // 最小显示长度，不够补零
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIColor *itemBoardColor;
@property (nonatomic, strong) UIColor *itemBgColor;

// 动画相关
@property (nonatomic, assign) NSTimeInterval duration;          // 动画总持续时间
@property (nonatomic, assign) NSTimeInterval durationOffset;    // 相邻两个数字动画持续时间间隔
@property (nonatomic, assign) BOOL isAscending;                 // 方向，默认为NO，向下

- (void)reloadView;
- (void)startAnimation;
- (void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
