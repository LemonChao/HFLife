//
//  CustomPromptBox.m
//  DuDuJR
//
//  Created by 张志超 on 2017/11/11.
//  Copyright © 2017年 张志超. All rights reserved.
//

#import "CustomPromptBox.h"

static CustomPromptBox *sharedInstance = nil;

@implementation CustomPromptBox

+ (CustomPromptBox *)sharedInstance {
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[CustomPromptBox alloc] init];
        }
    }
    return sharedInstance;
}

+ (void)showTextHud:(NSString *)text {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor blackColor];
    showView.frame = CGRectMake(1, 1, 1, 1);
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    //该方法过期
//    CGSize LabelSize = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(WIDTH - 20, 9000)];
    
   CGSize LabelSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 9000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size;
   
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = text;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [showView addSubview:label];
    showView.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 150, LabelSize.width+20,LabelSize.height +10);
    [UIView animateWithDuration:3.0 animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
}

@end
