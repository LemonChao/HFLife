//
//  UIButton+timer.m
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "UIButton+timer.h"

@implementation UIButton (timer)

//获取倒计时
- (void)setTheCountdownStartWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    [self setTitle:[NSString stringWithFormat:@"%ld%@", (long)timeLine, subTitle] forState:UIControlStateNormal];
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut >= 59) {
            self.accessibilityValue = @"";
        }
        if (timeOut == 0 || [self.accessibilityValue isEqualToString:@"stop"]) {
            self.accessibilityValue = @"";
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
                self.layer.borderColor = HEX_COLOR(0xCA1400).CGColor;
                self.userInteractionEnabled =YES;
            });
        } else {
            int seconds = (timeOut != 0) ? timeOut : timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle]forState:UIControlStateNormal];
                [self setTitleColor:HEX_COLOR(0x666666) forState:UIControlStateNormal];
                self.layer.borderColor = HEX_COLOR(0x666666).CGColor;
                self.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

//关闭计时器
- (void) cancleTimer:(void(^)(void))complate{
//    dispatch_cancel(self.source);
    self.accessibilityValue = @"stop";
}


@end
