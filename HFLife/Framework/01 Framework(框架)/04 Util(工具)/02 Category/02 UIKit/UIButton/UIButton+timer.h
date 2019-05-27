//
//  UIButton+timer.h
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (timer)
- (void)setTheCountdownStartWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
@property (nonatomic, strong)dispatch_source_t source;
@property(nonatomic, assign) BOOL  iscancel;
;
//关闭计时器
- (void) cancleTimer:(void(^)(void))complate;


@end

NS_ASSUME_NONNULL_END
